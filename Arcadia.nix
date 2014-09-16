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
      ./common/fonts.nix
    ];
  

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
      lm_sensors
    ];
  };

  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
    additionalOptions =
	''
      	    Option          "VertTwoFingerScroll"   "on"
            Option          "HorizTwoFingerScroll"  "on"
            Option          "EmulateTwoFingerMinW"  "8"
            Option          "EmulateTwoFingerMinZ"  "40"
            Option          "TapButton1"            "1"
	'';
  };

  services.xserver.config =
	''
	   Section "InputClass"
        	Identifier      "ThinkPad TrackPoint"
        	MatchProduct    "TPPS/2 IBM TrackPoint"
        	MatchDevicePath "/dev/input/event*"
        	Option          "EmulateWheel"          "true"
        	Option          "EmulateWheelButton"    "2"
        	Option          "XAxisMapping"          "6 7"
        	Option          "YAxisMapping"          "4 5"
	   EndSection
	'';

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
  services.thinkfan.sensor = "/sys/devices/platform/coretemp.0/temp1_input";
  services.acpid.enable = true;
}
