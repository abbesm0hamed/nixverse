{ config, lib, pkgs, ... }:

with lib;

{
  options.modules.system.core = {
    enable = mkEnableOption "core system configuration";
  };

  config = mkIf config.modules.system.core.enable {
    # Boot configuration - UEFI GRUB
    boot.loader.grub.enable = true;
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.device = "nodev";
    boot.loader.efi.canTouchEfiVariables = true;

    # Networking
    networking.networkmanager.enable = true;

    # Localization
    time.timeZone = "Africa/Tunis";
    i18n.defaultLocale = "en_US.UTF-8";

    # Audio
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Hardware support
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # System packages
    environment.systemPackages = with pkgs; [
      # Build essentials
      pkg-config
      gnumake
      cmake
      openssl.dev
      libxml2
      libxslt
      zlib
      libgit2
      heimdal
      krb5.dev
      gcc
      lact

      # Core system utilities
      wsdd
      wget
      curl
      unzip
      kitty
      ripgrep
      btop
      neofetch
      firefox
      git
      tree

      # Language Managers
      nodejs_24
      go
      python314
    ];
  };
}
