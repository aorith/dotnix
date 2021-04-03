{ config, pkgs, ... }:

{
  nix.gc.automatic = true;
  time.timeZone = "Europe/Madrid";

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
    list-packages =
      "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort -u";
  };
}
