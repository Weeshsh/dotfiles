{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/base.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/development.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/omniroute-legacy.nix
  ];

  networking.hostName = "nixoson_michael";

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;

  hardware.enableRedistributableFirmware = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
    ];
  };
  services.xserver.videoDrivers = [ "modesetting" ];
  boot.kernelParams = [ "i915.enable_guc=3" ];
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];

  system.stateVersion = "26.05";
}
