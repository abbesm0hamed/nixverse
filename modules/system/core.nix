{ config, lib, pkgs, ... }:

with lib;

{
  options.modules.system.core = {
    enable = mkEnableOption "core system configuration";
  };

  config = mkIf config.modules.system.core.enable {
    # Boot configuration
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Networking
    networking.networkmanager.enable = true;

    # Localization
    time.timeZone = "Africa/Tunis";
    i18n.defaultLocale = "en_US.UTF-8";

    # Audio
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Basic system packages
    environment.systemPackages = with pkgs; [
      firefox
      git
      curl
      wget
      unzip
      tree
    ];
  };
}
