{ pkgs, ... }:

{
  networking = {
    networkmanager = {
      enable = true;
      dns = "none";
    };

    resolvconf.useLocalResolver = true;

    firewall.allowedTCPPorts = [
      6666
      57621
      8080
    ];
  };

  services.nextdns = {
    enable = true;
    arguments = [
      "-profile"
      "f8ce7f"
      
      "-cache-size"
      "10MB"
    ];
  };

  systemd.services.nextdns-activate = {
    script = ''
      /run/current-system/sw/bin/nextdns activate
    '';
    
    after = [ "nextdns.service" ];
    wantedBy = [ "multi-user.target" ];
  };

  environment.systemPackages = [ pkgs.nextdns ];
}