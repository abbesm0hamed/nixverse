{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "abbes";
  home.homeDirectory = "/home/abbes";

  # This value determines the Home Manager release that your
  # configuration is compatible with.
  home.stateVersion = "24.05";

  # All packages from your Arch setup
  home.packages = with pkgs; [
    # Development tools
    neovim
    git
    lazygit
    docker-compose
    nodejs
    python3
    rustc
    cargo
    gcc
    gnumake
    
    # Terminal utilities
    kitty
    tmux
    fish
    starship
    ranger
    btop
    htop
    cava
    fastfetch
    ripgrep
    fd
    bat
    eza
    tree
    unzip
    curl
    wget
    
    # Wayland/Desktop utilities
    waybar
    wofi
    mako
    swww
    grim
    slurp
    wl-clipboard
    pavucontrol
    
    # Media applications
    mpv
    vlc
    gimp
    
    # Fonts (Nerd Fonts)
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
    
    # Other utilities
    firefox
    discord
    spotify
    obsidian
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

  # Fish shell with starship prompt
  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "eza -l --icons";
      la = "eza -la --icons";
      ls = "eza --icons";
      cat = "bat";
      grep = "rg";
      find = "fd";
      ".." = "cd ..";
      "..." = "cd ../..";
      vim = "nvim";
      vi = "nvim";
    };
    shellInit = ''
      # Set up starship prompt
      starship init fish | source
    '';
  };

  # Starship prompt configuration
  programs.starship = {
    enable = true;
    settings = {
      format = "$all$character";
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };

  # Kitty terminal configuration
  programs.kitty = {
    enable = true;
    settings = {
      # Kanagawa color scheme
      background = "#1F1F28";
      foreground = "#DCD7BA";
      cursor = "#C8C093";
      
      # Font configuration
      font_family = "JetBrainsMono Nerd Font";
      font_size = 12;
      
      # Window settings
      window_padding_width = 10;
      confirm_os_window_close = 0;
    };
  };

  # Tmux configuration
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    shortcut = "a";
    keyMode = "vi";
    extraConfig = ''
      # Kanagawa colors for tmux
      set -g status-bg "#2A2A37"
      set -g status-fg "#DCD7BA"
      set -g window-status-current-bg "#7E9CD8"
      set -g window-status-current-fg "#1F1F28"
      
      # Enable mouse support
      set -g mouse on
      
      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %
    '';
  };

  # Neovim configuration (basic setup)
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
