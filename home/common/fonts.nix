{ config, pkgs, lib, ... }:

{
  fonts.fontconfig.enable = true;
  
  home.packages = with pkgs; [
    # Programming fonts
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
    fira-code
    fira-code-symbols
    jetbrains-mono
    
    # System fonts
    inter
    roboto
    open-sans
    source-sans-pro
    
    # Arabic fonts
    amiri
    scheherazade-new
    
    # Emoji
    noto-fonts-emoji
    
    # Icon fonts
    font-awesome
    material-icons
  ];
}
