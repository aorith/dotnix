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
    "${dotnix}/cfg/gnome.nix"
    "${dotnix}/cfg/syncthing-aorith.nix"
    "${dotnix}/cfg/python.nix"
    #"${dotnix}/cfg/flatpak.nix"
    "${dotnix}/cfg/fonts.nix"
    "${dotnix}/private/virtualisation/common.nix"
    "${dotnix}/private/virtualisation/libvirt.nix"
    "${dotnix}/private/virtualisation/docker.nix"
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "curses";
  };

  programs.vim.defaultEditor = true;
  programs.bash = {
    enableCompletion = true;
    enableLsColors = true;
  };
  programs.iftop.enable = true;
  programs.iotop.enable = true;
  programs.mtr.enable = true;
  programs.traceroute.enable = true;
  powerManagement.enable = false;

  services = {
    openssh.enable = true;
    xserver.desktopManager.xfce.enable = true;
    xrdp.enable = true;
    xrdp.defaultWindowManager = "xfce4-session";
  };

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  system.stateVersion = "20.09";
}
