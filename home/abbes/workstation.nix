{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "abbes";
  home.homeDirectory = "/home/abbes";

  # This value determines the Home Manager release that your
  # configuration is compatible with.
  home.stateVersion = "25.05";

  # All packages from your Arch setup
  home.packages = with pkgs; [
    # Development tools
    neovim
    git
    lazygit
    docker-compose
    nodejs
    python3
    firefox
  ];

  # Git configuration
  programs.git = {
    enable = true;
    userName = "abbes";
    userEmail = "your-email@example.com"; # Update this
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  # Basic terminal
  programs.kitty = {
    enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
