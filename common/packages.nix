{ config, pkgs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # -env -qaP | grep wget
   environment.systemPackages = with pkgs; [
     wget
     chromium
     firefoxWrapper
     mpv
     vlc
     git
     vim
     sudo
     youtubeDL
     xcalib
     emacs
     argyllcms
     skype
     pidgin
     # adobe-reader # version 9?
     which
     curl
     unrar
     unzip
     xz
     zip
     unetbootin
     gimp
     dropbox
     keepassx2
     spotify
     file
     i3
     i3status
     dmenu   
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
