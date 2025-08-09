{ config, pkgs, ... }:
{
  imports = [
    ../../modules/core.nix
    ../../modules/devtools.nix
    ../../modules/wayland.nix
  ];
}

