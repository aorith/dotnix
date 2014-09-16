{config, pkgs, ...}:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    extraUsers.aorith = {
      name = "aorith";
      group = "aorith";
      uid = 1000;
      createHome = true;
      home = "/home/aorith";
      extraGroups = [ "users" "wheel" ];
      description = "Manuel Sánchez";
      shell = "/run/current-system/sw/bin/bash";
    };
    extraGroups.aorith.gid = 1000;
  };
}