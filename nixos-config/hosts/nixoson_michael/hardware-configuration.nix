{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/luks-d908d052-a289-438f-9149-2a46340a778c";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-d908d052-a289-438f-9149-2a46340a778c".device = "/dev/disk/by-uuid/d908d052-a289-438f-9149-2a46340a778c";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3A1B-F7F1";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
