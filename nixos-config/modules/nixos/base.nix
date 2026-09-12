{ pkgs, ... }:

{
  time.timeZone = "Europe/Warsaw";
  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  console.keyMap = "pl2";

  users.users.mikolaj = {
    isNormalUser = true;
    description = "Mikołaj";
    extraGroups = [
      "dialout"
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  programs.command-not-found.enable = false;

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    optimise.automatic = true;
  };
}
