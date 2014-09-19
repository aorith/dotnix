{config, pkgs, ...}:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    mutableUsers = true;
    extraUsers.aorith = {
      name = "aorith";
      group = "aorith";
      uid = 1000;
      createHome = true;
      home = "/home/aorith";
      extraGroups = [ "wheel" "networkmanager" "audio" ];
      description = "Manuel Sánchez";
      useDefaultShell = true;
    };
    extraGroups = {
      aorith.gid = 1000;
    };
  };
}
