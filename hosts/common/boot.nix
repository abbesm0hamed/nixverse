{ config, lib, pkgs, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;
  
  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # Enable firmware updates
  services.fwupd.enable = true;
  
  # Kernel parameters for better performance
  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "systemd.show_status=auto"
    "rd.udev.log_level=3"
  ];
  
  # Enable Plymouth for boot splash
  boot.plymouth.enable = true;
  
  # Filesystem support
  boot.supportedFilesystems = [ "ntfs" "exfat" ];
}
