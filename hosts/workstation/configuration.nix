{ config, pkgs, ... }:
{
  imports = [
    ../common.nix
    ../../modules/system/core.nix
    ../../modules/system/desktop.nix
    ../../modules/system/devtools.nix
    ../../modules/system/productivity.nix
  ];

  # Enable all modules for workstation
  modules.system.core.enable = true;
  modules.system.desktop.enable = true;
  modules.system.devtools.enable = true;
  modules.system.productivity.enable = true;

  # Niri configuration
  programs.niri.enable = true;
  
  # Enable XWayland for compatibility
  programs.xwayland.enable = true;

  # Additional services for workstation
  services.docker.enable = true;
  virtualisation.docker.enable = true;
  
  # Add user to docker group
  users.users.abbes.extraGroups = [ "docker" ];

  # System settings
  system.stateVersion = "24.05";
  networking.hostName = "workstation";

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}