{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  environment.systemPackages = with pkgs; [
    # utils
    wget
    curl
    bat
    jq
    lsof
    pstree
    unzip
    commonsCompress

    # system
    htop
    sysstat
    lm_sensors
    efibootmgr
    automake
    cmake
    gcc
    gdb
    fd
    file
    direnv
    bind
    binutils

    # editors
    vim
    neovim

    # dev
    git

    # terminals
    unstable.tmux
  ];

  nixpkgs.config.allowUnfree = true;
}
