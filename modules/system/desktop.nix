{ config, lib, pkgs, ... }:

with lib;

{
  options.modules.system.desktop = {
    enable = mkEnableOption "desktop environment";
  };

  config = mkIf config.modules.system.desktop.enable {
    # Wayland/Sway
    programs.sway.enable = true;
    programs.waybar.enable = true;
    
    # XDG Desktop Portal
    xdg.portal = {
      enable = true;
      wlr.enable = true;
    };

    # Display manager
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.sway}/bin/sway";
          user = "abbes";
        };
        default_session = initial_session;
      };
    };

    # Fonts
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    ];
  };
}
