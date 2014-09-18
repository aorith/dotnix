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
      ./common/desktop.nix
      ./common/misc.nix
    ];

  environment = {
    systemPackages = with pkgs; [
      acpi
      acpid
      wpa_supplicant
      thinkfan
      powertop
      lm_sensors
    ];
  };

  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
    palmDetect = true;
    vertEdgeScroll = true;
    horizontalScroll = true;
    tapButtons = true;
    accelFactor = "0.003";
    maxSpeed = "1.2";
#    additionalOptions =
#	''
#      	    Option          "VertTwoFingerScroll"   "on"
#            Option          "HorizTwoFingerScroll"  "on"
#            Option          "EmulateTwoFingerMinW"  "8"
#            Option          "EmulateTwoFingerMinZ"  "40"
#            Option          "TapButton1"            "1"
#	'';
  };

#  services.xserver.config =
#	''
#	   Section "InputClass"
#       	Identifier      "ThinkPad TrackPoint"
#       	MatchProduct    "TPPS/2 IBM TrackPoint"
#       	MatchDevicePath "/dev/input/event*"
#        	Option          "EmulateWheel"          "true"
#        	Option          "EmulateWheelButton"    "2"
#        	Option          "XAxisMapping"          "6 7"
#        	Option          "YAxisMapping"          "4 5"
#	   EndSection
#	'';

  hardware.trackpoint = {
      enable = true;
      emulateWheel = true;
  };

  networking = {
    networkmanager.enable = true;
    wireless = {
      enable = false;
      interfaces = [ "wlp3s0" ];
      userControlled.enable = true;
    };
    enableIPv6 = false;
    hostName = "Arcadia";
  };

  powerManagement = {
      enable = true;
      cpuFreqGovernor = "powersave";
      powerUpCommands = "powertop --auto-tune";
  };
  services.xserver.videoDrivers = ["intel"];
  services.thinkfan.enable = true;
  services.thinkfan.sensor = "/sys/devices/platform/coretemp.0/temp1_input";
  services.acpid.enable = true;
  services.xserver.vaapiDrivers = [ pkgs.vaapiIntel ];
  
  services.cron.systemCronJobs = [ "@reboot root /etc/nixos/dotnix/hw/pt.sh" ];

}
