{ config, pkgs, lib, isVM ? false, ... }:

{
  home.packages = with pkgs; [
    # Web browsers
    # firefox
    # chromium
    
    # Communication
    # discord
    # telegram-desktop
    # slack
    
    # Media
    # vlc
    # mpv
    # spotify
    
    # Graphics
    # gimp
    # inkscape
    # krita
    
    # Office
    # libreoffice
    
    # Development
    # vscode
    # zed-editor
    
    # System tools
    # gparted
    # filelight
    # baobab
    
    # File managers
    # nautilus
    # thunar
    
    # Archive tools
    # file-roller
    
    # PDF viewer
    # evince

    ghostty
    
    # Calculator
    gnome.gnome-calculator
  ] ++ lib.optionals (!isVM) [
    # Heavy applications only on physical machines
    # blender
    # kdenlive
    # obs-studio
  ];
  
  # Configure applications
  # programs.firefox = {
  #   enable = true;
  #   
  #   profiles.default = {
  #     settings = {
  #       "browser.startup.homepage" = "https://start.duckduckgo.com";
  #       "privacy.trackingprotection.enabled" = true;
  #       "dom.security.https_only_mode" = true;
  #     };
  #     
  #     extensions = with pkgs.nur.repos.rycee.firefox-addons; [
  #       ublock-origin
  #       privacy-badger
  #       decentraleyes
  #       clearurls
  #       bitwarden
  #     ];
  #   };
  # };
  
  programs.alacritty = {
    enable = true;
    
    settings = {
      window = {
        opacity = 0.9;
        padding = {
          x = 10;
          y = 10;
        };
      };
      
      font = {
        normal = {
          family = "JetBrains Mono";
          style = "Regular";
        };
        size = 12;
      };
      
      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
        
        normal = {
          black = "#45475a";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#bac2de";
        };
      };
      
      key_bindings = [
        { key = "V"; mods = "Control|Shift"; action = "Paste"; }
        { key = "C"; mods = "Control|Shift"; action = "Copy"; }
        { key = "Plus"; mods = "Control"; action = "IncreaseFontSize"; }
        { key = "Minus"; mods = "Control"; action = "DecreaseFontSize"; }
      ];
    };
  };
}
