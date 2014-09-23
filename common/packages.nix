{ config, pkgs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # -env -qaP | grep wget
   environment.systemPackages = with pkgs; [
     acpi linuxPackages.acpi_call lm_sensors powertop
     wget ntfs3g chromiumBeta firefoxWrapper
     mpv vlc git vimHugeX sudo youtubeDL xcalib most pulseaudio
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
     xorg.xev xorg.xbacklight xorg.xprop
     cups manpages freetype fontconfig p7zip gcc smartmontools
     sublime3 hexchat hello
     alsaLib alsaPlugins alsaUtils
     gstreamer
     gst_plugins_base gst_plugins_good
     gst_plugins_bad gst_plugins_ugly
     libmtp jmtpfs mtpfs
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
