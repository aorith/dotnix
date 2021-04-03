{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd = {
       availableKernelModules =
    [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
       kernelModules = [ ];
       postDeviceCommands = lib.mkAfter ''
          zfs rollback -r rpool/local/root@blank
       '';

    };
    kernelModules = [ "kvm-amd" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "elevator=none" ];
    extraModulePackages = [ ];
  };

  hardware.cpu.amd.updateMicrocode = true;

  services.fstrim.enable = true;
  services.zfs.autoScrub.enable = true;

  fileSystems."/" =
    { device = "rpool/local/root";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/96EC-6938";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    { device = "rpool/local/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "tank/home";
      fsType = "zfs";
    };

  fileSystems."/persist" =
    { device = "tank/persist";
      fsType = "zfs";
    };

  fileSystems."/data" =
    { device = "tank/data";
      fsType = "zfs";
    };

  fileSystems."/data/syncthing" =
    { device = "tank/data/syncthing";
      fsType = "zfs";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/2117a3fc-8e0e-495f-a564-fa8dc4c16137"; }
    ];

}
