# ~/nixos-config/modules/dev/default.nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    git
    python3
    nodejs
    go
    rust
  ];
  services.xserver.enable = false;
}

