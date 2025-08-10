{ config, lib, pkgs, ... }:

with lib;

{
  options.modules.system.productivity = {
    enable = mkEnableOption "productivity applications";
  };

  config = mkIf config.modules.system.productivity.enable {
    environment.systemPackages = with pkgs; [
      # Office and productivity
      libreoffice
      obsidian
      
      # Communication
      discord
      telegram-desktop
      
      # Media and creativity
      spotify
      audacity
      blender
      inkscape
      
      # Browsers
      firefox
      chromium
      
      # File sharing and cloud
      syncthing
      
      # System monitoring
      htop
      btop
      
      # Archive tools
      p7zip
      unrar
    ];
  };
}
