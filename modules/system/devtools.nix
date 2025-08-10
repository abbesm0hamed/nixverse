{ config, lib, pkgs, ... }:

with lib;

{
  options.modules.system.devtools = {
    enable = mkEnableOption "development tools";
  };

  config = mkIf config.modules.system.devtools.enable {
    environment.systemPackages = with pkgs; [
      # Essential tools only
      git
      neovim
      curl
      wget
    ];
  };
}
