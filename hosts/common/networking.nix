{ config, lib, pkgs, ... }:

{
  # Hostname (override in specific configs)
  networking.hostName = lib.mkDefault "nixos";
  
  # NetworkManager
  networking.networkmanager.enable = true;
  
  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ]; # SSH
    allowedUDPPorts = [ ];
  };
  
  # Enable SSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  
  # mDNS
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };
}
