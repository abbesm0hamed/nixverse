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

  # Desktop environment configured in desktop.nix (GNOME for VM compatibility)
  
  # User is configured in common.nix (imports users/abbes.nix)
  # Add docker group to existing user
  users.users.abbes.extraGroups = [ "docker" ];

  # Additional services for workstation
  virtualisation.docker.enable = true;

  # VM guest integrations for better clipboard, resolution changes, and time sync
  services.qemuGuest.enable = true;
  services.spice-vdagent.enable = true;

  # System settings
  system.stateVersion = "25.05";
  networking.hostName = "workstation";
}
