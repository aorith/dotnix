# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hw/t430.nix
      ./common/users.nix
      ./common/packages.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  # Select internationalisation properties.
   i18n = {
     consoleFont = "lat9w-16";
     consoleKeyMap = "es";
     defaultLocale = "es_ES.UTF-8";
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "es";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.kde4.enable = true;

  environment = {
    systemPackages = with pkgs; [
      acpi
      acpid
      wpa_supplicant
      wpa_supplicant_gui
      thinkfan
      powertop
    ];
  };

  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
  };

  networking = {
    wireless = {
      enable = true;
      interfaces = [ "wlp3s0" ];
      userControlled.enable = true;
    };
    enableIPv6 = false;
    hostName = "Arcadia";
  };

  powerManagement.enable = true;
  services.xserver.videoDrivers = ["intel"];
  services.thinkfan.enable = true;

}
