{ config, pkgs, lib, ... }:
let
  hostname = lib.removeSuffix "\n" (builtins.readFile /etc/hostname);
  dotnix = "/home/aorith/githome/dotnix";
in {
  imports = [
    "${dotnix}/private/hosts/${hostname}/variables.nix"
    ./persist.nix
    ./hardware.nix
    ./networking.nix
    "${dotnix}/cfg/common.nix"
    "${dotnix}/cfg/common-packages.nix"
    "${dotnix}/cfg/common-packages-gui.nix"
    #"${dotnix}/cfg/gnome.nix"
    "${dotnix}/cfg/syncthing-aorith.nix"
    "${dotnix}/cfg/python.nix"
    #"${dotnix}/cfg/flatpak.nix"
    "${dotnix}/cfg/fonts.nix"
  ];

  system.stateVersion = "20.09";

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
  programs.gnupg.agent.pinentryFlavor = "curses";

  programs.vim.defaultEditor = true;
  programs.bash.enableCompletion = true;
  programs.bash.enableLsColors = true;
  programs.iftop.enable = true;
  programs.iotop.enable = true;
  programs.mtr.enable = true;
  programs.traceroute.enable = true;
  powerManagement.enable = false;
  services.openssh.enable = true;

  services.xserver.videoDrivers = [ "modesetting" ];

  boot.supportedFilesystems = [ "zfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

}
