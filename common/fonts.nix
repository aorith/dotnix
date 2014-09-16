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
      bakoma_ttf
      clearlyU
      cm_unicode
      andagii
      bakoma_ttf
      inconsolata
      gentium
    ];
  };

}
