{ pkgs, ... }:

{
  nix.gc.automatic = true;

  security.sudo.wheelNeedsPassword = false;

  users.groups = {
    aorith = {
      name = "aorith";
      members = [ "aorith" ];
      gid = 9999;
    };
  };

  users.users = {
    aorith = {
      isNormalUser = true;
      description = "Manuel";
      uid = 9999;
      group = "aorith";
      home = "/home/aorith";
      createHome = true;
      extraGroups = [ "wheel" "networkmanager" "libvirtd" "lxd" ];
      shell = pkgs.bash;
    };
  };

  environment.shellAliases = {
    list-packages = "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort -u";
  };
}
