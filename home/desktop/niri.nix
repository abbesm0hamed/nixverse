{ config, pkgs, lib, dotfiles, ... }:

{
  # Niri configuration
  home.file.".config/niri/config.kdl".source = "${dotfiles}/niri/config.kdl";
  
  # Waybar configuration
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        
        modules-left = [ "niri/workspaces" "niri/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "battery" "tray" ];
        
        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
          };
        };
        
        "niri/window" = {
          format = "{}";
          max-length = 50;
        };
        
        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%Y-%m-%d}";
        };
        
        pulseaudio = {
          format = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };
        
        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ifname} ";
          format-disconnected = "Disconnected ⚠";
          on-click = "nm-connection-editor";
        };
        
        battery = {
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
        };
        
        tray = {
          icon-size = 21;
          spacing = 10;
        };
      };
    };
    
    style = ''
      * {
        font-family: "JetBrains Mono", monospace;
        font-size: 13px;
      }
      
      window#waybar {
        background-color: rgba(43, 48, 59, 0.8);
        border-bottom: 3px solid rgba(100, 114, 125, 0.5);
        color: #ffffff;
      }
      
      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #ffffff;
        border-bottom: 3px solid transparent;
      }
      
      #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
      }
      
      #workspaces button.active {
        background-color: #64727D;
        border-bottom: 3px solid #ffffff;
      }
    '';
  };
  
  # Rofi configuration
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = "Arc-Dark";
    
    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      drun-display-format = "{name}";
      disable-history = false;
      sidebar-mode = false;
    };
  };
  
  # Mako notification daemon
  services.mako = {
    enable = true;
    backgroundColor = "#2e3440";
    textColor = "#d8dee9";
    borderColor = "#88c0d0";
    borderRadius = 5;
    borderSize = 2;
    defaultTimeout = 5000;
  };
  
  # Additional Wayland tools
  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    swappy
    wf-recorder
  ];
}
