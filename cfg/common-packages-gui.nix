{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  environment.systemPackages = with pkgs; [
    # utils
    xclip
    autocutsel
    wmctrl
    xdotool
    xorg.xev
    xorg.xwininfo
    openvpn
    valgrind
    virt-manager
    qemu
    qemu_kvm

    # browsers
    firefox
    chromium
    google-chrome

    # chat
    discord
    hexchat

    # terminals
    unstable.alacritty
    unstable.kitty

    # media
    pulsemixer
    pavucontrol
    playerctl
    mpv
    vlc
    spotify

    # other
    joplin-desktop
    libreoffice
    flameshot
    keepassxc
  ];

  systemd.user.services.autocutsel = {
    description = "AutoCutSel";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "forking";
      Restart = "always";
      RestartSec = 2;
      # "-selection PRIMARY" syncs primary to clipboard - makes it hard to paste urls on the browser
      #ExecStartPre = "${pkgs.autocutsel}/bin/autocutsel -selection PRIMARY -fork";
      ExecStart = "${pkgs.autocutsel}/bin/autocutsel -fork";
    };
  };
  systemd.user.services.autocutsel.enable = true;
}
