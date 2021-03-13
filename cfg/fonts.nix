{ config, pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    jetbrains-mono
    hack-font
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    dina-font
    proggyfonts
  ];
}
