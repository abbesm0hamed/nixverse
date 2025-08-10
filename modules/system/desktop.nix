{ config, lib, pkgs, ... }:

with lib;

{
  options.modules.system.desktop = {
    enable = mkEnableOption "desktop environment";
  };

  config = mkIf config.modules.system.desktop.enable {
    # Niri and Wayland
    programs.niri.enable = true;
    programs.waybar.enable = true;
    
    # XDG Desktop Portal
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    # Display manager
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "niri-session";
          user = "abbes";
        };
        default_session = initial_session;
      };
    };

    # Desktop applications from Arch setup
    environment.systemPackages = with pkgs; [
      # Wayland utilities
      waybar
      wofi
      mako
      swww
      grim
      slurp
      wl-clipboard
      
      # Media
      mpv
      vlc
      gimp
      
      # System utilities
      btop
      cava
      ranger
      
      # Terminal and shell
      kitty
      fish
      starship
      
      # File management
      thunar
      
      # Other utilities
      fastfetch
      pavucontrol
    ];

    # Fonts
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    ];
  };
}
