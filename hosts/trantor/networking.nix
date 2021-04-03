{ config, pkgs, ... }: {
  networking = {
    hostName = config.my.hostname;
    hostId = config.my.hostid;
    usePredictableInterfaceNames = true;
    firewall.enable = false;

    bridges = { br0.interfaces = [ "enp8s0" ]; };

    interfaces = {
      enp6s0f0 = {
        ipv4.addresses = [{
          address = "192.168.1.7";
          prefixLength = 24;
        }];
      };
      br0 = {
        ipv4.addresses = [{
          address = "192.168.1.8";
          prefixLength = 24;
        }];
      };
    };

    defaultGateway = {
      address = "192.168.1.1";
      interface = "enp6s0f0";
    };

    nameservers = [ "192.168.1.5" ];
    search = [ "mono.lan" ];

    networkmanager = {
      enable = config.my.useNetworkManager;
      wifi.backend = "iwd";
      packages = [ pkgs.networkmanager_openvpn ];
      unmanaged = [ "enp8s0" ];
    };
  };
}
