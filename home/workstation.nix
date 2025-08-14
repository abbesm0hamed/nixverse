{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "abbes";
  home.homeDirectory = "/home/abbes";

  # This value determines the Home Manager release that your
  # configuration is compatible with.
  home.stateVersion = "25.05";

  # User packages - organized by category
  home.packages = with pkgs; [
    # Development tools
    neovim
    git
    lazygit
    docker-compose
    nodejs
    python3
    
    # System monitoring and utilities
    btop
    cava
    ranger
    yazi
    fastfetch
    
    # Terminal emulators (multiple options from your dotfiles)
    alacritty
    ghostty
    
    # Shell and terminal tools
    tmux
    fish
    starship
    
    # Wayland/NIRI specific tools
    waybar
    wofi
    mako
    wl-clipboard
    grim
    slurp
    swaylock
    
    # Media and graphics
    playerctl
    brightnessctl
    
    # Additional utilities
    curl
    wget
    unzip
    tree
    
    # Development environments (if needed)
    # vscode
    # vscodium
  ];

  # Wayland-friendly environment per-user
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GDK_BACKEND = "wayland,x11";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "abbes";
    userEmail = "abbesmohamed717@gmail.com"; 
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  # Enable programs without declarative configuration
  # (will use external config files from dotfiles)
  programs.kitty.enable = true;
  programs.fish.enable = true;
  programs.tmux.enable = true;
  programs.waybar.enable = true;
  services.mako.enable = true;
  programs.wofi.enable = true;
  programs.starship.enable = true;
  programs.alacritty.enable = true;

  # Autostart Waybar for Wayland sessions
  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar status bar";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # Default applications
  xdg.mimeApps.enable = true;

  # Dotfiles management - symlink config files from nixverse/dotfiles
  # This approach uses home.file for better Home Manager integration
  home.file.".config/nvim".source = ../dotfiles/.config/nvim;
  home.file.".config/kitty".source = ../dotfiles/.config/kitty;
  home.file.".config/fish".source = ../dotfiles/.config/fish;
  home.file.".config/waybar".source = ../dotfiles/.config/waybar;
  home.file.".config/mako".source = ../dotfiles/.config/mako;
  home.file.".config/ranger".source = ../dotfiles/.config/ranger;
  home.file.".config/btop".source = ../dotfiles/.config/btop;
  home.file.".config/cava".source = ../dotfiles/.config/cava;
  home.file.".config/yazi".source = ../dotfiles/.config/yazi;
  home.file.".config/starship.toml".source = ../dotfiles/.config/starship.toml;
  home.file.".config/alacritty".source = ../dotfiles/.config/alacritty;
  home.file.".config/ghostty".source = ../dotfiles/.config/ghostty;
  home.file.".config/swaylock".source = ../dotfiles/.config/swaylock;
  home.file.".config/niri".source = ../dotfiles/.config/niri;
  
  # Also link root dotfiles
  home.file.".tmux.conf".source = ../dotfiles/.tmux.conf;

  
  # Create screenshots directory
  home.file."Pictures/Screenshots/.keep".text = "";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
