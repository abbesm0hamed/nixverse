{ config, pkgs, ... }:
{
  imports = [
    ../common.nix
    ../../modules/system/core.nix
    ../../modules/system/devtools.nix
  ];

  # Enable modules for minimal setup
  modules.system.core.enable = true;
  modules.system.devtools.enable = true;

  # Minimal system settings
  system.stateVersion = "24.05";
  networking.hostName = "minimal";
}

