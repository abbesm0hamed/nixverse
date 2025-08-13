{ config, lib, pkgs, ... }:

with lib;

{
  options.modules.system.desktop = {
    enable = mkEnableOption "desktop environment";
  };

  config = mkIf config.modules.system.desktop.enable {
    # NIRI Wayland Compositor Configuration
    programs.niri.enable = true;
    
    # Display manager for NIRI
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    
    # Set NIRI as default session
    services.displayManager.defaultSession = "niri";
    
    # Essential Wayland services
    security.polkit.enable = true;
    services.dbus.enable = true;
    
    # XDG Desktop Portal for Wayland
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
    
    # Audio support
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Essential desktop packages
    environment.systemPackages = with pkgs; [
      # Terminal and basic tools
      kitty
      firefox
      git
      neovim
      
      # Wayland utilities
      wl-clipboard
      grim
      slurp
      swappy
      
      # System utilities
      brightnessctl
      playerctl
      pavucontrol
    ];

    # Basic fonts
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
    ];
  };
}
