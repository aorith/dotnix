{ config, pkgs, ... }:

{

  # powertop custom service
  systemd.services.powertop = {
    description = "Powertop tunings";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "root";
      Environment="TERM=xterm";
      ExecStart = ''
        ${pkgs.stdenv.shell} -c "powertop --auto-tune"
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
    nixosManual.showManual = true;
  };

  hardware = {
    pulseaudio.enable = true;
  };

}
