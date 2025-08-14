{ config, lib, pkgs, ... }:

with lib;

{
  options.modules.system.desktop = {
    enable = mkEnableOption "desktop environment";
  };

  config = mkIf config.modules.system.desktop.enable {
    
    # Graphics drivers (uncomment the one you need)
    # Intel graphics
    hardware.graphics.extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
    
    # NIRI Wayland Compositor Configuration
    programs.niri.enable = true;
    
    # Display manager for NIRI (GDM has better Wayland support)
    services.xserver.enable = true;
    services.xserver.displayManager.gdm = {
      enable = true;
      wayland = true;
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

    # Wayland-friendly environment
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1"; # Electron/Chromium apps on Wayland
      MOZ_ENABLE_WAYLAND = "1"; # Firefox on Wayland
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      GDK_BACKEND = "wayland,x11";
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_TYPE = "wayland";
    };

    # PAM for screen locker
    security.pam.services.swaylock = {};

    # File and desktop helpers
    services.gvfs.enable = true;
    services.tumbler.enable = true;
    services.gnome.gnome-keyring.enable = true;

    # Essential desktop packages
    environment.systemPackages = with pkgs; [
      # Compositor
      niri

      # Terminal and basic tools
      kitty
      ghostty
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
      
      # Audio control CLI used by keybinds
      wireplumber
      pamixer
      pulseaudio

      # File manager and services
      xfce.thunar
    ];

    # Basic fonts
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
    ];
  };
}
