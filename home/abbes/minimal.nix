{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "abbes";
  home.homeDirectory = "/home/abbes";

  # This value determines the Home Manager release that your
  # configuration is compatible with.
  home.stateVersion = "24.05";

  # Minimal packages for quick access
  home.packages = with pkgs; [
    # Essential tools
    git
    curl
    wget
    unzip
    tree
    
    # Terminal utilities
    htop
    btop
    neofetch
    
    # Text editors
    neovim
    
    # Shell
    fish
  ];

  # Basic git configuration
  programs.git = {
    enable = true;
    userName = "abbes";
    userEmail = "your-email@example.com"; # Update this
  };

  # Fish shell configuration
  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
