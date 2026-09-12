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

      "-listen"
      "127.0.0.1:53"

      "-listen"
      "[::1]:53"
    ];
  };

  environment.systemPackages = [ pkgs.nextdns ];
}