{ config, pkgs, ... }:
{
  imports = [
    ../common.nix
    ../../modules/system/core.nix
    ../../modules/system/desktop.nix
    ../../modules/system/devtools.nix
    ../../modules/system/productivity.nix
  ];

  # Enable essential modules for workstation
  modules.system.core.enable = true;
  modules.system.desktop.enable = true;
  modules.system.devtools.enable = true;
  # modules.system.productivity.enable = true;  # Disabled for now

  # Niri configuration
  programs.niri.enable = true;

  # fish configuration
  programs.fish.enable = true;
  
  # Enable XWayland for compatibility
  programs.xwayland.enable = true;

  # Additional services for workstation
  virtualisation.docker.enable = true;
  
  # Add user to docker group
  users.users.abbes.extraGroups = [ "docker" ];

  # System settings
  system.stateVersion = "25.05";
  networking.hostName = "workstation";

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}