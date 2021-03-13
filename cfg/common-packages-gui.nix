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

    # browsers
    firefox
    chromium
    google-chrome

    # chat
    discord
    hexchat

    # terminals
    unstable.alacritty
    kitty

    # media
    pulsemixer
    pavucontrol
    playerctl
    mpv
    vlc
    spotify

    # other
    libreoffice
  ];

  systemd.user.services.autocutsel = {
    description = "AutoCutSel";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "forking";
      Restart = "always";
      RestartSec = 2;
      ExecStartPre = "${pkgs.autocutsel}/bin/autocutsel -fork";
      ExecStart = "${pkgs.autocutsel}/bin/autocutsel -selection PRIMARY -fork";
    };
  };
  systemd.user.services.autocutsel.enable = true;
}
