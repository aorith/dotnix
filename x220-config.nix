{ config, pkgs, ... }:
let
  useNetworkManager = true;
in
{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "x220";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.wireless.iwd.enable = true;

  networking.interfaces = {
    enp0s25.useDHCP = useNetworkManager;
    wlan0.useDHCP = useNetworkManager;
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

  networking.bridges = {
    br0 = {
      interfaces = [ "enp0s25" ];
    };
  };

  # systemd-networkd
  systemd.network = {
    enable = !useNetworkManager;
    netdevs.br0.netdevConfig = {
      Name = "br0";
      Kind = "bridge";
    };
    networks = {
      br0.extraConfig = ''
        [Match]
        Name=br0

        [Network]
        DHCP=ipv4
      '';
      enp0s25.extraConfig = ''
        [Match]
        Name=enp0s25

        [Network]
        Bridge=br0
      '';
      wlan0.extraConfig = ''
        [Match]
        Name=wlan0

        [Network]
        DHCP=ipv4
      '';
    };
  };

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

  # nspawn
  systemd.targets.machines.enable = true;

  fileSystems."/" =
    {
      # intentionally not specifying the device here, so it gets picked from hardware-configuration.nix
      fsType = "ext4";
      options = [ "defaults" "discard" ];
    };

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
      ./cfg/containers/test.nix
      ./private/nspawn/debian.nix
    ];
}
