{ config, ... }:
{
  services = {
    syncthing = {
      enable = config.my.syncthing.enable;
      user = "${config.my.user.name}";
      group = "${config.my.rwgroup.name}";
      configDir = "${config.my.user.home}/.config/syncthing";
      dataDir = "${config.my.syncthing.datadir}";
    };
  };
  systemd.tmpfiles.rules = if "${config.my.user.home}/Syncthing"
  == "${config.my.syncthing.datadir}" then
    [ ]
  else
    [
      "L ${config.my.user.home}/Syncthing - - - - ${config.my.syncthing.datadir}"
    ];
}
