{ config, lib, pkgs, niri, ... }:

{
  # Enable Niri
  programs.niri.enable = true;
  
  # Required for Niri
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  
  # Display manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "greeter";
      };
    };
  };
  
  # Portal for screen sharing
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
  
  # Required packages for Niri
  environment.systemPackages = with pkgs; [
    waybar
    rofi-wayland
    wl-clipboard
    grim
    slurp
    swappy
    mako
    alacritty
    brightnessctl
    playerctl
  ];
  
  # Enable systemd user services
  systemd.user.services.waybar = {
    description = "Waybar status bar";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    script = "${pkgs.waybar}/bin/waybar";
  };
}
