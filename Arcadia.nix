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
      wpa_supplicant
      thinkfan
    ];
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
      #powerUpCommands = "powertop --auto-tune";
  };
  
  services = {
    thinkfan = {
      enable = true;
      sensor = "/sys/devices/platform/coretemp.0/hwmon/hwmon1/temp1_input";
    };
    acpid.enable = true;
    cron.systemCronJobs = [ "@reboot root powertop --auto-tune" ];
    xserver = {
      videoDrivers = [ "intel" ];
      vaapiDrivers = [ pkgs.vaapiIntel ];
      synaptics = {
	enable = true;
	twoFingerScroll = true;
	palmDetect = true;
	vertEdgeScroll = false;
	horizontalScroll = true;
	tapButtons = true;
	accelFactor = "0.003";
	maxSpeed = "1.2";
      };
    };
  };
  
  hardware.trackpoint = {
    enable = true;
    emulateWheel = true;
    sensitivity = 255;
    speed = 130;
  };
  
}
