# programs/ghostty.nix
{ config, pkgs, lib, ... }:

{
  programs.ghostty = {
    enable = true;
    
    settings = {
      # Font configuration
      font-family = "JetBrains Mono";
      font-size = 12;
      font-thicken = true;
      
      # Window settings
      window-decoration = true;
      window-title-font-family = "JetBrains Mono";
      window-padding-x = 10;
      window-padding-y = 10;
      window-inherit-working-directory = true;
      window-inherit-font-size = true;
      
      # Theme and colors (Catppuccin Mocha theme)
      theme = "catppuccin-mocha";
      
      # Alternative: Custom color scheme
      # background = "1e1e2e";
      # foreground = "cdd6f4";
      # cursor-color = "f5e0dc";
      # selection-background = "585b70";
      # selection-foreground = "cdd6f4";
      
      # Color palette (if using custom colors)
      # palette = [
      #   # Black
      #   "45475a"
      #   "585b70"
      #   # Red  
      #   "f38ba8"
      #   "f38ba8"
      #   # Green
      #   "a6e3a1"
      #   "a6e3a1"
      #   # Yellow
      #   "f9e2af"
      #   "f9e2af"
      #   # Blue
      #   "89b4fa"
      #   "89b4fa"
      #   # Magenta
      #   "f5c2e7"
      #   "f5c2e7"
      #   # Cyan
      #   "94e2d5"
      #   "94e2d5"
      #   # White
      #   "bac2de"
      #   "a6adc8"
      # ];
      
      # Cursor
      cursor-style = "block";
      cursor-style-blink = false;
      
      # Scrollback
      scrollback-limit = 10000;
      
      # Shell integration
      shell-integration = "fish";
      shell-integration-features = "cursor,sudo,title";
      
      # Mouse
      mouse-hide-while-typing = true;
      copy-on-select = false;
      
      # Misc
      confirm-close-surface = false;
      quit-after-last-window-closed = true;
      
      # Bell
      audible-bell = false;
      visual-bell = false;
      
      # Advanced
      unfocused-split-opacity = 0.7;
      command = "${pkgs.fish}/bin/fish";
      
      # Performance
      macos-non-native-fullscreen = false;
      
      # Key bindings
      keybind = [
        # Copy/Paste
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
        
        # Font size
        "ctrl+plus=increase_font_size:1"
        "ctrl+minus=decrease_font_size:1"
        "ctrl+zero=reset_font_size"
        
        # Scrollback
        "ctrl+shift+up=scroll_page_up"
        "ctrl+shift+down=scroll_page_down"
        "ctrl+shift+home=scroll_to_top"
        "ctrl+shift+end=scroll_to_bottom"
        
        # Tabs (if using tabs)
        "ctrl+shift+t=new_tab"
        "ctrl+shift+w=close_surface"
        "ctrl+shift+page_up=previous_tab"
        "ctrl+shift+page_down=next_tab"
        
        # Splits (if using splits)
        "ctrl+shift+enter=new_split:right"
        "ctrl+shift+backslash=new_split:down"
        "ctrl+shift+left=goto_split:left"
        "ctrl+shift+right=goto_split:right"
        "ctrl+shift+up=goto_split:up"
        "ctrl+shift+down=goto_split:down"
        
        # Search
        "ctrl+shift+f=search"
        
        # Quick terminal
        "ctrl+shift+grave=toggle_quick_terminal"
      ];
    };
  };
  
  # Alternative configuration using raw config file
  # Uncomment this if you prefer to use a separate config file
  # home.file.".config/ghostty/config".text = ''
  #   font-family = JetBrains Mono
  #   font-size = 12
  #   theme = catppuccin-mocha
  #   
  #   window-padding-x = 10
  #   window-padding-y = 10
  #   
  #   shell-integration = fish
  #   cursor-style = block
  #   
  #   keybind = ctrl+shift+c=copy_to_clipboard
  #   keybind = ctrl+shift+v=paste_from_clipboard
  #   keybind = ctrl+plus=increase_font_size:1
  #   keybind = ctrl+minus=decrease_font_size:1
  # '';
}
