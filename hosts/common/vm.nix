{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
  ];

  # VirtualBox-specific hardware modules
  boot.initrd.availableKernelModules = [ 
    "ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" 
    # VirtualBox specific
    "vboxguest" "vboxsf" "vboxvideo"
  ];
  boot.kernelModules = [ ];
  
  # VirtualBox Guest Additions
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;
  
  # Enable VirtualBox services for better integration
  services.xserver.videoDrivers = [ "virtualbox" "vmware" "cirrus" "vesa" "modesetting" ];
  
  # VirtualBox-optimized boot
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda"; # VirtualBox typically uses sda
    version = 2;
  };
  
  # VirtualBox disk configuration
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  
  # Enable 3D acceleration for VirtualBox
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  
  # VirtualBox networking (typically enp0s3)
  networking.interfaces.enp0s3.useDHCP = lib.mkDefault true;
  
  # Shared folders support (optional)
  fileSystems."/mnt/shared" = {
    fsType = "vboxsf";
    device = "shared"; # Name of the shared folder in VirtualBox
    options = [ "rw" "uid=1000" "gid=100" ];
  };
  
  # Performance optimizations for VirtualBox
  services.xserver.displayManager.gdm.wayland = false; # Use X11 for better compatibility
  
  # Audio in VirtualBox
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire.enable = true;
}
