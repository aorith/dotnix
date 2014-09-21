{ config, pkgs, ... }:

{

  # powertop custom service
  systemd.services.powertop = {
    enable = true;
    description = "Powertop tunings";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Environment="TERM=xterm";
      ExecStart = ''
        ${pkgs.stdenv.shell} -c "/run/current-system/sw/sbin/powertop --auto-tune";
      '';
    };
  };


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
