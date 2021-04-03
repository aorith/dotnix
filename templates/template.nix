{ config, pkgs, ... }:
let
  password = CHANGETHIS;
  hostName = "trantor";
  hostId = "e7919205";
in {
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  environment.systemPackages = with pkgs; [ wget vim firefox git mkpasswd ];

  time.timeZone = "Europe/Madrid";
  networking = {
    firewall.enable = false;
    hostName = "${hostName}"; # Define your hostname.
    hostId = "${hostId}";
    useDHCP = false;
    interfaces = {
      enp6s0f0.useDHCP = true;
      enp6s0f1.useDHCP = true;
      enp8s0.useDHCP = true;
    };
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "es";
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome3.enable = true;
    layout = "es";
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  services.openssh.enable = true;
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];

  users = {
    mutableUsers = false;
    groups = {
      aorith = {
        name = "aorith";
        members = [ "aorith" ];
        gid = 9999;
      };
    };
    extraUsers.root.password = "${password}";
    users = {
      aorith = {
        isNormalUser = true;
        description = "Manuel";
        uid = 9999;
        group = "aorith";
        home = "/home/aorith";
        createHome = true;
        extraGroups = [ "wheel" "networkmanager" ];
        shell = pkgs.bash;
        password = "${password}";
      };
    };
  };

  system.stateVersion = "20.09"; # Did you read the comment?
}

