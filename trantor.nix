{ config, pkgs, ... }:
let
  useNetworkManager = true;
in
{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "trantor";


  # Networking
  networking.useDHCP = false;
  networking.interfaces = {
    ens18.useDHCP = useNetworkManager;
    #br0.ipv4.addresses = [
    #  { address = "192.168.1.237"; prefixLength = 24; }
    #];
  };
  # NetworkManager
  networking.networkmanager = {
    enable = useNetworkManager;
    wifi.backend = "iwd";
    packages = [ pkgs.networkmanager_openvpn ];
  };

  #networking.bridges = {
  #  br0 = {
  #    interfaces = [ "enp0s25" ];
  #  };
  #};

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "es";
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Libvirtd
  virtualisation.libvirtd.enable = true;

  # Filesystem overrides
  services.fstrim.enable = true;
  services.btrfs.autoScrub.enable = true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/ROOT";
    fsType = "xfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/EFI";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/RAID";
    fsType = "btrfs";
    options = [ "subvol=HOME" "compress=zstd" ];
  };

  fileSystems."/DATA" = {
    device = "/dev/disk/by-label/RAID";
    fsType = "btrfs";
    options = [ "subvol=DATA" "compress=zstd" ];
  };

  swapDevices = [
    {
      device = "/dev/disk/by-label/SWAP";
    }
  ];

  imports =
    [
      ./cfg/common.nix
      ./cfg/common-packages.nix
      ./cfg/common-packages-gui.nix
      ./cfg/gnome.nix
      ./cfg/syncthing-aorith.nix
      ./cfg/python.nix
      ./cfg/flatpak.nix
      ./cfg/fonts.nix
    ];
}
