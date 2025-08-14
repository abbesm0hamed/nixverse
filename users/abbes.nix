{ config, pkgs, ... }:

{
  users.users.abbes = {
    isNormalUser = true;
    description = "Abbes";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish;
  };
  
  # Enable fish shell system-wide
  programs.fish.enable = true;
}
