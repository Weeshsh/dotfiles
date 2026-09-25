{ pkgs, ... }:

let
  compose = "${pkgs.docker-compose}/bin/docker-compose";

  firecrawlCompose = pkgs.writeText "firecrawl-compose.yaml" ''
    name: firecrawl

    services:
      api:
        image: ghcr.io/firecrawl/firecrawl:2.11.334-production

        restart: unless-stopped

        ulimits:
          nofile:
            soft: 65535
            hard: 65535

        environment:
          HOST: "0.0.0.0"
          PORT: "3002"

          REDIS_URL: "redis://redis:6379"
          REDIS_RATE_LIMIT_URL: "redis://redis:6379"

          PLAYWRIGHT_MICROSERVICE_URL: "http://playwright-service:3000/scrape"

          POSTGRES_USER: "postgres"
          POSTGRES_PASSWORD: "postgres"
          POSTGRES_DB: "postgres"
          POSTGRES_HOST: "nuq-postgres"
          POSTGRES_PORT: "5432"

          USE_DB_AUTHENTICATION: "false"

          NUM_WORKERS_PER_QUEUE: "2"
          CRAWL_CONCURRENT_REQUESTS: "4"
          MAX_CONCURRENT_JOBS: "2"
          BROWSER_POOL_SIZE: "2"

          NUQ_RABBITMQ_URL: "amqp://rabbitmq:5672"
          HARNESS_STARTUP_TIMEOUT_MS: "60000"

          ENV: "local"

        command:
          - node
          - dist/src/harness.js
          - --start-docker

        ports:
          - "127.0.0.1:3002:3002"

        depends_on:
          redis:
            condition: service_started

          playwright-service:
            condition: service_started

          rabbitmq:
            condition: service_healthy

          nuq-postgres:
            condition: service_started

        networks:
          - backend

        extra_hosts:
          - "host.docker.internal:host-gateway"

        logging:
          driver: json-file
          options:
            max-size: "10m"
            max-file: "3"
            compress: "true"

      playwright-service:
        image: ghcr.io/firecrawl/playwright-service:latest

        restart: unless-stopped

        environment:
          PORT: "3000"
          MAX_CONCURRENT_PAGES: "4"

        tmpfs:
          - "/tmp/.cache:noexec,nosuid,size=1g"

        networks:
          - backend

        logging:
          driver: json-file
          options:
            max-size: "10m"
            max-file: "3"
            compress: "true"

      redis:
        image: redis:8.8.3-alpine3.23

        restart: unless-stopped

        command:
          - redis-server
          - --bind
          - "0.0.0.0"

        networks:
          - backend

        logging:
          driver: json-file
          options:
            max-size: "5m"
            max-file: "2"
            compress: "true"

      rabbitmq:
        image: rabbitmq:3.13.7-management

        restart: unless-stopped

        command:
          - rabbitmq-server

        healthcheck:
          test:
            - CMD
            - rabbitmq-diagnostics
            - "-q"
            - check_running
          interval: 5s
          timeout: 5s
          retries: 10
          start_period: 5s

        networks:
          - backend

        logging:
          driver: json-file
          options:
            max-size: "5m"
            max-file: "2"
            compress: "true"

      nuq-postgres:
        image: ghcr.io/firecrawl/nuq-postgres:latest

        restart: unless-stopped

        environment:
          POSTGRES_USER: "postgres"
          POSTGRES_PASSWORD: "postgres"
          POSTGRES_DB: "postgres"

        networks:
          - backend

        logging:
          driver: json-file
          options:
            max-size: "10m"
            max-file: "3"
            compress: "true"

    networks:
      backend:
        driver: bridge
  '';
in
{
  systemd.services.firecrawl = {
    description = "Self-hosted Firecrawl";

    wantedBy = [ "multi-user.target" ];

    requires = [ "docker.service" ];

    after = [
      "docker.service"
      "network-online.target"
    ];

    wants = [
      "network-online.target"
    ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;

      ExecStartPre = ''
        ${compose} \
          -f ${firecrawlCompose} \
          pull
      '';

      ExecStart = ''
        ${compose} \
          -f ${firecrawlCompose} \
          up -d --remove-orphans
      '';

      ExecStop = ''
        ${compose} \
          -f ${firecrawlCompose} \
          down --remove-orphans
      '';

      TimeoutStartSec = "0";
      TimeoutStopSec = "120";
    };
  };
}