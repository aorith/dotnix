{ lib, ... }:
let
  hostname = lib.removeSuffix "\n" (builtins.readFile /etc/hostname);
  dotnix = "/home/aorith/githome/dotnix";
in {
  imports = [ "${dotnix}/hosts/${hostname}/main.nix" ];
  environment.etc."nixos/configuration.nix".source =
    "${dotnix}/hosts/configuration.nix";
}

