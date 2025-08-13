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
  
  # NIRI configuration
  xdg.configFile."niri/config.kdl".text = ''
    // NIRI Configuration
    
    input {
        keyboard {
            xkb {
                layout "us"
            }
        }
        
        touchpad {
            tap
            natural-scroll
            accel-speed 0.2
        }
        
        mouse {
            accel-speed 0.2
        }
    }
    
    output "eDP-1" {
        scale 1.0
    }
    
    layout {
        gaps 16
        
        center-focused-column "never"
        
        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }
        
        default-column-width { proportion 0.5; }
    }
    
    prefer-no-csd
    
    hotkey-overlay {
        skip-at-startup
    }
    
    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
    
    animations {
        slowdown 1.0
        
        workspace-switch {
            spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
        }
        
        horizontal-view-movement {
            spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
        }
        
        window-open {
            duration-ms 150
            curve "ease-out-expo"
        }
        
        window-close {
            duration-ms 150
            curve "ease-out-quad"
        }
    }
    
    window-rule {
        match app-id="firefox"
        default-column-width { proportion 0.75; }
    }
    
    window-rule {
        match app-id="org.gnome.Nautilus"
        default-column-width { proportion 0.6; }
    }
    
    binds {
        // Mod key is Super (Windows key)
        
        // Basic window management
        Mod+Return { spawn "kitty"; }
        Mod+D { spawn "wofi" "--show" "drun"; }
        Mod+Q { close-window; }
        
        // Focus movement
        Mod+Left  { focus-column-left; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }
        Mod+Right { focus-column-right; }
        Mod+H     { focus-column-left; }
        Mod+J     { focus-window-down; }
        Mod+K     { focus-window-up; }
        Mod+L     { focus-column-right; }
        
        // Move windows
        Mod+Shift+Left  { move-column-left; }
        Mod+Shift+Down  { move-window-down; }
        Mod+Shift+Up    { move-window-up; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+H     { move-column-left; }
        Mod+Shift+J     { move-window-down; }
        Mod+Shift+K     { move-window-up; }
        Mod+Shift+L     { move-column-right; }
        
        // Workspaces
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        
        // Move windows to workspaces
        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }
        
        // Column management
        Mod+Comma  { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }
        
        // Resize
        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { reset-window-height; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        
        // Screenshots
        Print { screenshot; }
        Mod+Print { screenshot-screen; }
        Alt+Print { screenshot-window; }
        
        // System
        Mod+Shift+E { quit; }
        Mod+Shift+P { power-off-monitors; }
        
        // Media keys
        XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
        XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
        XF86AudioMute        { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute     { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
        
        XF86MonBrightnessUp   { spawn "brightnessctl" "set" "10%+"; }
        XF86MonBrightnessDown { spawn "brightnessctl" "set" "10%-"; }
        
        XF86AudioPlay { spawn "playerctl" "play-pause"; }
        XF86AudioNext { spawn "playerctl" "next"; }
        XF86AudioPrev { spawn "playerctl" "previous"; }
    }
  '';
  
  # Create screenshots directory
  home.file."Pictures/Screenshots/.keep".text = "";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
