{ config, lib, pkgs, niri, ... }:

{
  imports = [
    ../../modules/desktop/niri.nix
    ../../modules/development
    ../../modules/services/docker.nix
  ];

  # Desktop environment
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
  };

  # Niri window manager
  programs.niri.enable = true;
  
  # Additional workstation packages
  environment.systemPackages = with pkgs; [
    # Development tools
    vscode
    docker-compose
    nodejs
    python3
    
    # Desktop applications
    firefox
    thunderbird
    gimp
    libreoffice
    
    # Media
    vlc
    spotify
    
    # System tools
    gparted
    wireshark
    
    # Your custom packages
    zen-browser
  ];

  # Enable Docker
  virtualisation.docker.enable = true;
  
  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  
  # Printing
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns = true;
  };
}
