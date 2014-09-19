# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hw/asrock.nix
      ./common/users.nix
      ./common/packages.nix
      ./common/fonts.nix
      ./common/desktop.nix
      ./common/misc.nix
    ];

  environment = {
    systemPackages = with pkgs; [
      calibre
    ];
  };


  networking = {
    networkmanager.enable = true;
    enableIPv6 = true;
    hostName = "trantor";
  };

  powerManagement = {
      enable = true;
  };
  
  services = {
    printing.enable = true;
    acpid.enable = true;
    xserver = {
      videoDrivers = [ "nouveau" ];
    # config = ''
    # '';
    };
  };
  
}
