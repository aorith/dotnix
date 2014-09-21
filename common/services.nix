{ config, pkgs, ... }:

{

  services = {
    openssh.enable = true;
    fail2ban.enable = true;
    locate.enable = true;
    avahi.enable = true; # zeroconf
    avahi.nssmdns = true; # local hostnames with avahi
    ntp.enable = true;
    nixosManual.enable = true; 
    nixosManual.showManual = true;
  };

  hardware = {
    pulseaudio.enable = true;
  };

}
