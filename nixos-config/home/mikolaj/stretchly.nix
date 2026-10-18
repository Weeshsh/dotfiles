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

  home.file.".config/Stretchly/config.json".text = builtins.toJSON {
    microbreakInterval = 15;           
    microbreakDuration = 30;           
    breakInterval = 60;                
    breakDuration = 600;               
    microbreakStrictMode = false;
    breakStrictMode = false;
    morningHour = "9";
    afternoonHour = "17";
    showBreaksAsRegularWindows = false;
    monitorDnd = true;
  };
}