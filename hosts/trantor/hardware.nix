{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    supportedFilesystems = [ "zfs" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
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

  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    opengl.enable = true;
    video.hidpi.enable = true;
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
  };

  services = {
    xserver.videoDrivers = [ "nvidia_390" ];
    udev.extraRules = ''
      KERNEL=="sd[a-z]*[0-9]*|mmcblk[0-9]*p[0-9]*|nvme[0-9]*n[0-9]*p[0-9]*", ENV{ID_FS_TYPE}=="zfs_member", ATTR{../queue/scheduler}="none"
    '';
    fstrim.enable = true;
    zfs.autoScrub.enable = true;
  };

  fileSystems = {
    "/" = {
      device = "rpool/local/root";
      fsType = "zfs";
      neededForBoot = true;
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/96EC-6938";
      fsType = "vfat";
    };
    "/nix" = {
      device = "rpool/local/nix";
      fsType = "zfs";
      neededForBoot = true;
    };
    "/home" = {
      device = "tank/home";
      fsType = "zfs";
      neededForBoot = true;
    };
    "/persist" = {
      device = "tank/persist";
      fsType = "zfs";
      neededForBoot = true;
    };
    "/data" = {
      device = "tank/data";
      fsType = "zfs";
    };
    "/data/syncthing" = {
      device = "tank/data/syncthing";
      fsType = "zfs";
    };
    "/var/lib/libvirt" = {
      device = "tank/persist/var_lib_libvirt";
      fsType = "zfs";
      neededForBoot = true;
    };
    "/var/lib/libvirt/images" = {
      device = "tank/persist/var_lib_libvirt/images";
      fsType = "zfs";
      neededForBoot = true;
    };
    "/var/lib/containers" = {
      device = "tank/persist/var_lib_containers";
      fsType = "zfs";
      neededForBoot = true;
    };
    "/etc/containers" = {
      device = "tank/persist/etc_containers";
      fsType = "zfs";
      neededForBoot = true;
    };
    "/data/bigfiles" = {
      device = "tank/data/bigfiles";
      fsType = "zfs";
    };
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/2117a3fc-8e0e-495f-a564-fa8dc4c16137"; }];
}
