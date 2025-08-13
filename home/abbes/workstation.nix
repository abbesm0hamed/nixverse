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
    
    # Browsers and media
    firefox
    
    # System monitoring and utilities
    btop
    cava
    ranger
    
    # Terminal and shell
    tmux
    fish
    
    # Wayland/NIRI specific tools
    waybar
    wofi
    mako
    wl-clipboard
    grim
    slurp
    
    # Additional utilities
    curl
    wget
    unzip
    tree
  ];

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

  # Terminal configuration
  programs.kitty = {
    enable = true;
    theme = "Kanagawa";
    settings = {
      font_family = "JetBrains Mono";
      font_size = 12;
      background_opacity = "0.9";
    };
  };
  
  # Fish shell configuration
  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      la = "ls -la";
      vim = "nvim";
      grep = "rg";
    };
  };
  
  # Tmux configuration
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    keyMode = "vi";
    mouse = true;
  };
  
  # Waybar configuration for NIRI
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "niri/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "battery" "tray" ];
        
        "niri/workspaces" = {
          format = "{name}";
        };
        
        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%A, %B %d, %Y (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };
        
        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" ];
          };
          on-click = "pavucontrol";
        };
        
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
        };
      };
    };
  };
  
  # Mako notification daemon
  services.mako = {
    enable = true;
    backgroundColor = "#1f1f28";
    textColor = "#dcd7ba";
    borderColor = "#54546d";
    borderRadius = 5;
    borderSize = 2;
    defaultTimeout = 5000;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
