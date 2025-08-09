{ config, pkgs, ... }:

{
  home.username = "abbes";
  home.homeDirectory = "/home/abbes";
  home.stateVersion = "25.05";

  imports = [
    ./programs/kitty.nix
    ./programs/nvim.nix
    ./programs/wofi.nix
    ./programs/wlogout.nix
    ./desktop/wayland.nix
  ];

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
