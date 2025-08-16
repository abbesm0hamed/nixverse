{ config, lib, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./networking.nix
    ./locale.nix
    ./users.nix
  ];

  # Nix settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "root" "@wheel" ];
    };
    
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # System packages available to all configurations
  environment.systemPackages = with pkgs; [
    # Essential tools
    vim
    wget
    curl
    git
    htop
    tree
    unzip
    zip
    
    # Network tools
    networkmanager
    openssh
    
    # Build tools
    gcc
    gnumake
  ];

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Security
  security.sudo.wheelNeedsPassword = false; # Adjust as needed
  
  system.stateVersion = "24.05";
}
