# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  # Imports Additional Modules
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];
  
  # Specifies Kernal Packages
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Root File Configurations
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b3c3b559-1fcd-4ff9-b549-e75f94a5520e";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/C0A9-017C";
      fsType = "vfat";
    };

  fileSystems."/run/media/wellerbp/Storage" =
    { device = "/dev/disk/by-uuid/f943ef2a-4b7b-4c4f-938c-a258c61b0003";
      fsType = "ext4";
    };

  #Swap Device Configurations
  swapDevices =
    [ { device = "/dev/disk/by-uuid/7d138ca9-bd91-47b3-a011-200fd68c190a"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  # Host Platform Architecture: Specifies Package Management 
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Sets the CPU Frequency:
  # "performance": The CPU will run at the maximum frequency at all times.
  # "powersave": The CPU will run at the minimum frequency at all times, saving power.
  # "ondemand": The CPU frequency will scale up when the system is under load, and scale down when the system is idle. This provides a balance between performance and power saving.
  # "conservative": Similar to "ondemand", but the CPU frequency is scaled more conservatively, prioritizing power saving.
  # "userspace": Allows user-space control of the CPU frequency.
  # "schedutil": Utilizes the scheduler's information to adjust the frequency, aiming to dynamically balance performance and power saving.
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  # Determines whether Intel microcode updates are enabled
  # Microcode updates can fix bugs or address security vulnerabilities in the CPU
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # GPU Driver Information:
  # https://nixos.wiki/wiki/AMD_GPU
  services.xserver.videoDrivers = [ "amdgpu" ];
 
   systemd.tmpfiles.rules = [
    "L+	/opt/rocm/hip	-	-	-	-	${pkgs.hip}"
  ];
  
  # Additional OpenGL Packages
  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime
    amdvlk
  ];
  
  # Additional 32-bit packages for OpenGL
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];
  
  # Enable Direct Rendering Infrastructure (DRI) support
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
}