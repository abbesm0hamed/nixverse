# ~/nixos-config/modules/workstation/default.nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    git
    python3
    nodejs
    libreoffice
    discord
    teams
  ];
  services.xserver.enable = true;
}

