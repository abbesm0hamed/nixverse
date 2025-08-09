{ config, lib, pkgs, ... }:

with lib;

{
  options.modules.system.devtools = {
    enable = mkEnableOption "development tools";
  };

  config = mkIf config.modules.system.devtools.enable {
    environment.systemPackages = with pkgs; [
      # Editors
      neovim
      
      # Version control
      git
      lazygit
      
      # Languages
      nodejs
      python3
      rustc
      cargo
      
      # Tools
      kitty
      tmux
      ripgrep
      fd
      bat
      eza
      
      # Build tools
      gcc
      gnumake
    ];
  };
}
