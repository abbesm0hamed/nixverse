{ config, lib, pkgs, ... }:

{
  # System hostname
  networking.hostName = "nixos-minimal";
  
  # Minimal package set
  environment.systemPackages = with pkgs; [
    # Essential tools only
    vim
    wget
    curl
    git
    htop
    tree
    tmux
    
    # Text editors
    nano
    
    # Network tools
    networkmanager-openvpn
  ];
  
  # Disable unnecessary services
  services.printing.enable = false;
  hardware.bluetooth.enable = false;
  
  # Enable only essential services
  services.timesyncd.enable = true;
  
  # Minimal desktop (optional)
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = true;
  };
}
