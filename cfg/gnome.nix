{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager = {
      defaultSession = "gnome-xorg";
      gdm.enable = true;
    };
    desktopManager.gnome3.enable = true;
    layout = "es";
    libinput.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      gnome3.gnome-tweaks
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.appindicator
      gnomeExtensions.sound-output-device-chooser
    ];
  };
}
