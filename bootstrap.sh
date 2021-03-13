#!/usr/bin/env bash

_info() { echo -e "[$(tput setaf 4) INFO $(tput sgr0)] $*"; }
_err() { echo -e "[$(tput setaf 1) ERROR $(tput sgr0)] $*"; }

_link() {
    local src tgt
    [[ -n "$1" ]] || { _err "_link(): No parameters on _link()."; return 1; }
    src="$1"
    [[ -e "$src" ]] || { _err "_link(): Source file doesn't exist: \"${src}\""; return 1; }
    [[ -n "$2" ]] && tgt="$2" || tgt="$1"
    sudo ln -sfv "$(pwd -P)/${src}" "/etc/nixos/${tgt}" || \
        { _err "_link(): Couldn't make a link of \"$src\" in \"$tgt\""; return 1; }
}

_check_requisites() {
    _info "Checking the config file ..."
    if [[ ! -e "${HOSTNAME}-config.nix" ]]; then
        _err "File ${HOSTNAME}-config.nix is missing."
        _err "Hostname \"${HOSTNAME}\" doesn't have a configuration yet."
        exit 1
    fi
    _info "Checking /etc/nixos/configuration.nix ..."
    if ! grep -wq "./${HOSTNAME}-config.nix" "/etc/nixos/configuration.nix"; then
        _err "Before bootstrapping, please add the import of \"${HOSTNAME}-config.nix\" to /etc/nixos/configuration.nix"
        exit 1
    fi
    _info "Checking for sudo privileges ..."
    sudo true || { _err "Bootstrapping requires sudo privileges to link config files and rebuild the system."; exit 1; }
}

_link_config() {
    _info "Creating the symlinks for the configuration ..."
    _link "${HOSTNAME}-config.nix" || return 10
    _link "cfg" || return 11
}

_add_unstable_channel() {
    local channels
    channels="$(sudo nix-channel --list)"
    if [[ $? -eq 0 ]] && ! grep -q 'nixos-unstable' <<< "$channels"; then
        _info "Adding unstable channel ..."
        sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
        sudo nix-channel --update nixos-unstable
    fi
}

_check_requisites
_info "Bootstrapping ${HOSTNAME} ..."
_link_config || exit $?
_add_unstable_channel
_info "Executing nixos-rebuild switch --upgrade"
sudo nixos-rebuild switch --upgrade

