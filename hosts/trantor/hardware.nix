{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.cpu.amd.updateMicrocode = true;

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/027B-C9BD";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "tank/home";
    fsType = "zfs";
  };

  services.fstrim.enable = true;
  services.zfs.autoScrub.enable = true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/ROOT";
    fsType = "ext4";
  };

  swapDevices = [ ];
}
