## ~/githome/dotnix

### Bootstrap a new machine

1. Install NixOS
2. Create the file ${HOSTNAME}-config.nix and import it on /etc/nixos/configuration.nix

```nix
# /etc/nixos/configuration.nix
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./x220-config.nix
    ];

# [ ... ]
```

3. That file should import all the configurations required from ./cfg, example:

```nix
# x220-config.nix
{
  imports =
    [
      ./cfg/common.nix
      ./cfg/syncthing-<username>.nix
      ./cfg/x220-packages.nix
    ];
}
```
