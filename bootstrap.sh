#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

HOST_CONF="./dotnix/hosts/${HOSTNAME}/main.nix"

_info() { echo -e "[$(tput setaf 4) INFO $(tput sgr0)] $*"; }
_err() { echo -e "[$(tput setaf 1) ERROR $(tput sgr0)] $*"; }

_check_requisites() {
    _info "Checking the config file ..."
    if [[ ! -e "../${HOST_CONF}" ]]; then
        _err "File ${HOST_CONF} is missing."
        _err "Hostname \"${HOSTNAME}\" doesn't have a configuration yet."
        return 1
    fi

    _info "Checking for sudo privileges ..."
    sudo true || { _err "Bootstrapping requires sudo privileges to link config files and rebuild the system."; return 1; }

    _info "Creating the symlink for configuration.nix ..."
    [[ "$(pwd -P)/hosts/configuration.nix" == "$(readlink -f "/etc/nixos/configuration.nix")" ]] || \
        sudo ln -Tsvf "$(pwd -P)/hosts/configuration.nix" "/etc/nixos/configuration.nix"

    [[ -z "$1" ]] || return 0
    [[ -n "$PRIVATE_GITHOME" ]] || { _err "This config requires private dotfiles."; return 1; }
    [[ "$(readlink -f "${PRIVATE_GITHOME}/dotnix/private")" == "$(readlink -f "${HOME}/githome/dotnix/private")" ]] || \
        ln -Tsvf "${PRIVATE_GITHOME}/dotnix/private" ~/githome/dotnix/private
}

_add_extra_channels() {
    local channels
    channels="$(sudo nix-channel --list)"
    if [[ $? -eq 0 ]] && ! grep -q 'nixos-unstable' <<< "$channels"; then
        _info "Adding unstable channel ..."
        sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
        sudo nix-channel --update nixos-unstable
    fi

    if [[ $? -eq 0 ]] && ! grep -q 'nixos-hardware' <<< "$channels"; then
        _info "Adding nixos-hardware channel ..."
        sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
        sudo nix-channel --update nixos-hardware
    fi
}

[[ "$1" != "skip-private" ]] || SKIP_PRIVATE=1

if [[ "$1" == "rollback" ]]; then
    _info "Running \"nixos-rebuild switch --rollback\" ..."
    sudo nixos-rebuild switch --rollback
else
    _check_requisites $SKIP_PRIVATE || exit $?
    _info "Bootstrapping ${HOSTNAME} ..."
    _add_extra_channels
    _info "Executing nixos-rebuild switch --upgrade"
    sudo nixos-rebuild switch --upgrade && \
        _info "Rebuild Done - deleting older generations ..." && \
        sudo nix-env --delete-generations +20 && \
        sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +20 && \
        _info "Running nix-store --gc ..." && \
        sudo nix-store --gc && \
        _info "Bootstrap complete!"
fi
