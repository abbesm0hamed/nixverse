{ config, lib, pkgs, ... }:

with lib;

{
  options.modules.system.productivity = {
    enable = mkEnableOption "productivity applications";
  };

  config = mkIf config.modules.system.productivity.enable {
    environment.systemPackages = with pkgs; [
      # Minimal productivity tools
      firefox
    ];
  };
}
