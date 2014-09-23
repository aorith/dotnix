{ config, pkgs, ... }:

{
        
  services.xserver = {
    desktopManager = { default = "none"; kde4.enable = true; };
    displayManager = { kdm.enable = true; slim.enable = false; };
    enable = true;
  };
 

  environment = {
    systemPackages = with pkgs; [
      kde4.l10n.es
      kde4.calligra
      kde4.networkmanagement
      pkgs.kde4.kdemultimedia pkgs.kde4.kdegraphics pkgs.kde4.kdeutils
      pkgs.kde4.applications pkgs.kde4.kdegames pkgs.kde4.kdeedu pkgs.kde4.kdebindings
      pkgs.kde4.kdeaccessibility pkgs.kde4.kde_baseapps pkgs.kde4.kactivities 
      pkgs.kde4.kdeadmin pkgs.kde4.kdeartwork pkgs.kde4.kde_base_artwork 
      pkgs.kde4.kdenetwork pkgs.kde4.kdepim pkgs.kde4.kdepimlibs pkgs.kde4.kdeplasma_addons 
      pkgs.kde4.kdesdk pkgs.kde4.kdetoys pkgs.kde4.kde_wallpapers pkgs.kde4.kdewebdev
      pkgs.kde4.oxygen_icons pkgs.kde4.kdebase_workspace pkgs.kde4.kdelibs pkgs.kde4.kdevelop pkgs.kde4.kdevplatform
      pkgs.oxygen_gtk
      pkgs.kde4.ksaneplugin
      pkgs.xclip
      pkgs.kde4.print_manager
      pkgs.pmutils
      pkgs.shared_mime_info
      pkgs.kde4.kde_gtk_config pkgs.kde4.kdevelop pkgs.kde4.kdesdk_kioslaves
      pkgs.kde4.ktorrent
    ];
  };

  nixpkgs.config = {
    packageOverrides = pkgs: {
       # kde4 = pkgs.kde412;
    };
  };
}
