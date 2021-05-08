{ config, pkgs, ... }:

{
  time.timeZone = "Europe/Madrid";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "es";
  };

  nix = {
    gc.automatic = true;
    autoOptimiseStore = true;
  };

  services.journald.extraConfig = ''
    SystemMaxUse=300M
    MaxFileSec=7day
  '';

  users.groups = {
    "${config.my.user.name}" = {
      name = "${config.my.user.name}";
      members = [ "${config.my.user.name}" ];
      gid = config.my.user.uid;
    };

    "${config.my.rwgroup.name}" = {
      name = "${config.my.rwgroup.name}";
      members = config.my.rwgroup.members;
      gid = config.my.rwgroup.gid;
    };
  };

  users.mutableUsers = false;
  users.extraUsers.root.hashedPassword = "${config.my.root.hashedpassword}";
  users.users = {
    "${config.my.user.name}" = {
      name = "${config.my.user.name}";
      isNormalUser = true;
      description = "Manuel";
      uid = config.my.user.uid;
      group = "${config.my.user.name}";
      home = "${config.my.user.home}";
      createHome = true;
      extraGroups = config.my.user.extragroups;
      shell = pkgs.bash;
      hashedPassword = "${config.my.user.hashedpassword}";
      openssh.authorizedKeys.keys = config.my.authorizedKeys;
    };
  };

  security.sudo.wheelNeedsPassword = false;

  environment.shellAliases = {
    dotnix = "cd /home/${config.my.user.name}/githome/dotnix";
    list-packages =
      "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort -u";
  };
}
