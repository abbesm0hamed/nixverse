{ config, pkgs, ... }:

{
  users.users.abbes = {
    isNormalUser = true;
    description = "Abbes";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish;
  };
  
  programs.zsh.enable = true;
}
