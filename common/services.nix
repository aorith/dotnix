{ config, pkgs, ... }:

{

  services = {
    openssh.enable = true;
  };

  hardware = {
    pulseaudio.enable = true;
  };

}
