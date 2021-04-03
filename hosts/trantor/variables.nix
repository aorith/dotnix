{ config, lib, options, ... }: {
  options.my = lib.mkOption {
    type = lib.types.attrs;
    default = { };
  };

  config.my.hostname = "trantor";
  config.my.hostid = "e7919205";
  config.my.useNetworkManager = true;
  config.my.user = {
    name = "aorith";
    home = "/home/aorith";
    uid = 9999;
    extragroups = [ "wheel" "networkmanager" "libvirtd" "lxd" ];
  };
  config.my.rwgroup = {
    name = "${config.my.hostname}";
    gid = 5000;
    members = [ "${config.my.user.name}" ];
  };

  config.my.syncthing = {
    enable = true;
    datadir = "/tank/data/Syncthing";
  };
}
