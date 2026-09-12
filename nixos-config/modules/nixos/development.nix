{ pkgs, ... }:

{
  virtualisation.docker.enable = true;

  services.mysql = {
    enable = true;
    package = pkgs.mariadb_114;
  };
}
