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
     kde4.l10n.es
     kde4.calligra
   ];
}
