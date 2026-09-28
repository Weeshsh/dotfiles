{ config, inputs, pkgs, ... }:

let
  hermesPkg = inputs.hermes-agent.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  imports = [
    inputs.hermes-agent.homeManagerModules.default
  ];

  programs.hermes-agent.enable = true;

  home.sessionVariables = {
    FIRECRAWL_API_URL = "http://127.0.0.1:3002";
  };

  systemd.user.services.hermes-gateway = {
    Unit = {
      Description = "Hermes Agent Gateway";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      Type = "simple";

      Environment = [
        "HERMES_HOME=${config.home.homeDirectory}/.hermes"
        "FIRECRAWL_API_URL=http://127.0.0.1:3002"
      ];

      ExecStart = "${hermesPkg}/bin/hermes gateway run";

      Restart = "on-failure";
      RestartSec = 5;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}