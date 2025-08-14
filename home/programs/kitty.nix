{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "FiraCode Nerd Font";
      font_size = 11;
      background_opacity = "0.9";
      
      # Colors (you can customize these)
      foreground = "#ffffff";
      background = "#1e1e1e";
      
      # Key bindings
      map = "ctrl+shift+c copy_to_clipboard";
      map = "ctrl+shift+v paste_from_clipboard";
    };
  };
}
