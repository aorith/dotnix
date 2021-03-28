#!/usr/bin/env bash

_info() { echo -e "[$(tput setaf 4) INFO $(tput sgr0)] $*"; }
_err() { echo -e "[$(tput setaf 1) ERROR $(tput sgr0)] $*"; }

_link() {
    local src tgt src_dir
    src_dir="$(pwd -P)"
    [[ -n "$1" ]] || { _err "_link(): No parameters on _link()."; return 1; }
    src="$1"
    [[ -e "$src" ]] || { _err "_link(): Source file doesn't exist: \"${src}\""; return 1; }
    [[ -n "$2" ]] && tgt="$2" || tgt="$1"
    [[ "$(readlink -f "/etc/nixos/${tgt}")" == "$(readlink -f "${src_dir}/${src}")" ]] || \
        sudo ln -sfv "${src_dir}/${src}" "/etc/nixos/${tgt}" || \
        { _err "_link(): Couldn't make a link of \"$src\" in \"$tgt\""; return 1; }
}

_check_requisites() {
    _info "Checking the config file ..."
    if [[ ! -e "${HOSTNAME}.nix" ]]; then
        _err "File ${HOSTNAME}.nix is missing."
        _err "Hostname \"${HOSTNAME}\" doesn't have a configuration yet."
        exit 1
    fi
    _info "Checking /etc/nixos/configuration.nix ..."
    if ! grep -wq "./${HOSTNAME}.nix" "/etc/nixos/configuration.nix"; then
        _err "Before bootstrapping, please add the import of \"${HOSTNAME}.nix\" to /etc/nixos/configuration.nix"
        exit 1
    fi
    _info "Checking for sudo privileges ..."
    sudo true || { _err "Bootstrapping requires sudo privileges to link config files and rebuild the system."; exit 1; }

    [[ -n "$PRIVATE_GITHOME" ]] || { _err "This config requires private dotfiles."; exit 1; }
    [[ "$(readlink -f "${PRIVATE_GITHOME}/dotnix/private")" == "$(readlink -f "${HOME}/githome/dotnix/private")" ]] || \
        ln -svf "${PRIVATE_GITHOME}/dotnix/private" ~/githome/dotnix/private
}

_link_config() {
    _info "Creating the symlinks for the configuration ..."
    _link "${HOSTNAME}.nix" || return 10
    _link "cfg" || return 11
    _link "private" || return 12
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

if [[ "$1" == "rollback" ]]; then
    _info "Running \"nixos-rebuild switch --rollback\" ..."
    sudo nixos-rebuild switch --rollback
else
    _check_requisites
    _info "Bootstrapping ${HOSTNAME} ..."
    _link_config || exit $?
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
