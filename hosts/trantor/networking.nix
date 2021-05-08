{ config, pkgs, lib, ... }: {
  networking = {
    hostName = config.my.hostname;
    hostId = config.my.hostid;
    usePredictableInterfaceNames = true;
    firewall.enable = lib.mkForce false;

    useNetworkd = true;
    useDHCP = false;
    #search = [ "mono.lan" ];

    #  networkmanager = {
    #    enable = false;
    #    wifi.backend = "iwd";
    #    packages = [ pkgs.networkmanager_openvpn ];
    #    unmanaged = [ "enp7s0" ];
    #  };
    #users.users."${config.my.user.name}".extraGroups = [ "networkmanager" ];
  };

  services.timesyncd.enable = true;
  services.resolved = {
    enable = true;
    dnssec = "false";
    llmnr = "false";
    domains = [ "mono.lan" ];
    fallbackDns = [ "8.8.8.8" "1.1.1.1" ];
  };
  systemd.network = {
    enable = true;
    netdevs.br0.netdevConfig = {
      Name = "br0";
      Kind = "bridge";
    };
    networks = {
      br0.extraConfig = ''
        [Match]
        Name = br0

        [Network]
        Address = 192.168.1.7/24
        Gateway = 192.168.1.1
        DNS = 192.168.1.5
      '';
      enp7s0.extraConfig = ''
        [Match]
        Name = enp7s0

        [Network]
        Bridge = br0
      '';
    };
  };

}
