{ config, pkgs, stdenv, fetchGit, ... }:

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
    fzf
    tree
    pstree
    unzip
    commonsCompress
    shellcheck
    manpages
    bash-completion
    nix-bash-completions
    gnupg
    gptfdisk
    cdrkit

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
    kvm

    # editors
    vim
    neovim

    # dev
    git
    debootstrap

    # terminals
    #unstable.tmux
    (callPackage ./../pkgs/tmux { })
  ];

  nixpkgs.config.allowUnfree = true;
}

