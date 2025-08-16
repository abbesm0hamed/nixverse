{ config, lib, pkgs, ... }:

{
  # Time zone
  time.timeZone = "Africa/Tunis";
  
  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";
  
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ar_TN.UTF-8";
    LC_IDENTIFICATION = "ar_TN.UTF-8";
    LC_MEASUREMENT = "ar_TN.UTF-8";
    LC_MONETARY = "ar_TN.UTF-8";
    LC_NAME = "ar_TN.UTF-8";
    LC_NUMERIC = "ar_TN.UTF-8";
    LC_PAPER = "ar_TN.UTF-8";
    LC_TELEPHONE = "ar_TN.UTF-8";
    LC_TIME = "ar_TN.UTF-8";
  };

  # Console configuration
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # X11 keymap
  services.xserver.xkb = {
    layout = "us,ar";
    options = "grp:alt_shift_toggle";
  };
}
