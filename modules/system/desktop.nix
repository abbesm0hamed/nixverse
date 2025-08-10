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

    # Display manager - SDDM
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    
    # Auto-login configuration
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "abbes";

    # Essential desktop packages only
    environment.systemPackages = with pkgs; [
      # Essential Wayland utilities
      waybar
      kitty  # Terminal
    ];

    # Basic fonts
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
    ];
  };
}
