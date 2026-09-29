{ pkgs, ... }:
{
systemd.user.services.stretchly = {
  Unit = {
    Description = "Stretchly break reminder";
    PartOf = ["graphical-session.target"];
    After = ["graphical-session.target"];
  };
  Service = {
    Type = "exec";
    ExecStart = "${pkgs.stretchly}/bin/stretchly";
    Restart = "on-failure";
    RestartSec = "10s";
    TimeoutStopSec = "30s";
  };
  Install.WantedBy = ["graphical-session.target"];
  };
}
