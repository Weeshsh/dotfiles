{ pkgs, ... }:

let
  omnirouteBin = "/home/mikolaj/.npm-global/bin/omniroute";
in
{
  systemd.services.omniroute = {
    description = "OmniRoute server (legacy npm installation)";
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];

    unitConfig.ConditionPathExists = omnirouteBin;

    path = [ pkgs.nodejs ];

    environment = {
      OMNIROUTE_SERVER_HOST = "0.0.0.0";
    };

    serviceConfig = {
      Type = "simple";
      User = "mikolaj";
      WorkingDirectory = "/home/mikolaj";
      ExecStart = "${omnirouteBin} serve --no-open";
      Restart = "on-failure";
      RestartSec = "10s";
      TimeoutStopSec = "30s";
    };
  };
}
