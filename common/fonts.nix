{ config, pkgs, ... }:

{

  fonts = {
    enableFontDir = true;
    enableCoreFonts = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs ; [
      liberation_ttf
      ttf_bitstream_vera
      dejavu_fonts
      terminus_font
      vistafonts
      gentium
      bakoma_ttf
      andagii
      cm_unicode
      clearlyU
        xorg.fontadobeutopiatype1
    	xorg.fontalias
    	xorg.fontarabicmisc
    	xorg.fontbh100dpi
    	xorg.fontbh75dpi
    	xorg.fontbhlucidatypewriter100dpi
    	xorg.fontbhlucidatypewriter75dpi
    	xorg.fontbhttf
    	xorg.fontbhtype1
    	xorg.fontbitstream100dpi
    	xorg.fontbitstream75dpi
    	xorg.fontbitstreamtype1
    	xorg.fontcronyxcyrillic
    	xorg.fontcursormisc
	xorg.fontibmtype1
	xorg.fontutil
	xorg.fontxfree86type1
    ];
  };

}
