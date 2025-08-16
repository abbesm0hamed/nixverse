{ config, lib, pkgs, ... }:

{
  # Enable Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
  
  # Docker Compose
  environment.systemPackages = with pkgs; [
    docker-compose
    lazydocker  # TUI for Docker
  ];
  
  # Enable container runtime
  virtualisation.containers.enable = true;
  
  # Podman as alternative (optional)
  # virtualisation.podman = {
  #   enable = true;
  #   dockerCompat = true;
  # };
}
