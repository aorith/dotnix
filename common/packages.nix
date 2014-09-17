{ config, pkgs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # -env -qaP | grep wget
   environment.systemPackages = with pkgs; [
     wget
     chromium
     mpv
     git
     vim
     sudo
     youtubeDL
   ];

   nixpkgs.config = {

    allowUnfree = true;

    firefox = {
     enableGoogleTalkPlugin = true;
     enableAdobeFlash = true;
    };

    chromium = {
     enablePepperFlash = true; # Chromium removed support for Mozilla (NPAPI) plugins so Adobe Flash no longer works 
     enablePepperPDF = true;
    };

  };
}
