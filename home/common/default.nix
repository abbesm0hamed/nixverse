{ config, pkgs, lib, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    ./fonts.nix
  ];

  # Home Manager settings
  programs.home-manager.enable = true;
  
  # Basic packages for all configurations
  home.packages = with pkgs; [
    # Archives
    zip
    unzip
    p7zip
    
    # Utils
    ripgrep
    fd
    bat
    exa
    tree
    htop
    
    # Network
    wget
    curl
    
    # Media
    ffmpeg
    imagemagick
  ];
  
  # XDG directories
  xdg.enable = true;
  
  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "zen-browser";
    TERMINAL = "ghostty";
  };
}
