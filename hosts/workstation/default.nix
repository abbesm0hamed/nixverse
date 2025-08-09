{ config, pkgs, ... }:

{
  # Common configuration for all hosts
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # System packages that should be on every machine
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    vim
    htop
  ];

  # Basic services
  services.openssh.enable = true;
  
  # User configuration
  imports = [ ../users/abbes.nix ];
}
