{ config, pkgs, ... }:

{
  users.users.abbes = {
    isNormalUser = true;
    description = "Abbes";
    extraGroups = [ 
      "wheel" 
      "networkmanager" 
      "audio" 
      "video"
      "docker"  # if using docker
      "libvirtd"  # if using virtualization
    ];
    shell = pkgs.fish;
  };
  
  programs.fish.enable = true;
}
