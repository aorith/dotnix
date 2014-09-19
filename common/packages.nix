{ config, pkgs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # -env -qaP | grep wget
   environment.systemPackages = with pkgs; [
     wget ntfs3g chromiumDev firefoxWrapper
     mpv vlc git vim sudo youtubeDL xcalib most
     emacs
     emacs24Packages.autoComplete
     emacs24Packages.colorTheme
     emacs24Packages.colorThemeSolarized
     emacs24Packages.notmuch
     emacs24Packages.org
     emacs24Packages.phpMode
     argyllcms skype pidgin
     # adobe-reader # version 9?
     which curl unrar unzip xz zip unetbootin
     libreoffice gimp dropbox keepassx2
     spotify file i3 i3status dmenu
     sdparm hdparm hddtemp cdrkit dvdplusrwtools
     usbutils mesa lshw ethtool iw
     hplip foo2zjs foomatic_filters fuse
     imagemagick wireshark pstree screen aspell
     indent diffutils gawk colordiff parted lvm2 gparted
     htop atop iftop iotop gnupg espeak sox
     autoconf libtool gettext gnumake automake
     cmake ant pkgconfig intltool maven ccache
     binutils docutils gdb lsof xorg.xsetroot
     xorg.xhost xsel xorg.xinit xorg.setxkbmap
     xorg.xev xorg.xbacklight xorg.xprop kde4.ktorrent
     cups manpages freetype fontconfig p7zip gcc smartmontools
     sublime3 linuxPackages.acpi_call
   ];

   nixpkgs.config = {

    allowUnfree = true;

    firefox = {
     #enableGoogleTalkPlugin = true;
     enableAdobeFlash = true;
    };

    chromium = {
     enablePepperFlash = true; # Chromium removed support for Mozilla (NPAPI) plugins so Adobe Flash no longer works 
     #enablePepperPDF = true;
    };

  };
}
