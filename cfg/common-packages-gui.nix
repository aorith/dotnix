{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  environment.systemPackages = with pkgs; [
    # utils
    xclip
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
}
