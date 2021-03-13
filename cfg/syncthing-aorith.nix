{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    syncthing
  ];

  services = {
    syncthing = {
      enable = true;
      user = "aorith";
      dataDir = "/home/aorith/Syncthing";
      configDir = "/home/aorith/.config/syncthing";
    };
  };
}
