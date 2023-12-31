{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Imports Modules
      ./nixos-modules/packages.nix        # Package management
      ./nixos-modules/localization.nix    # Localization settings
      ./nixos-modules/programs.nix        # Program configurations
      ./nixos-modules/services.nix        # Service configurations
      ./nixos-modules/users.nix           # User account definitions
    ];

   nix = {
    # Nix Store & Package Management
    settings = {
      substituters = [ 
          "https://ezkea.cachix.org" 
          "https://cache.nixos.org" 
          "https://ai.cachix.org" 
          "https://hyprland.cachix.org" 
      ];
      trusted-public-keys = [ 
          "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" 
          "cache.nixos.org-1:6NCHdD59X431o0gWypbOdQjF2c/64Kyli4Wb6KpZ/jY=" 
          "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc=" 
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" 
      ];
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"]; # Enable Nix Flakes
    };
    # Optimization and Garbage Collection
    optimise.automatic = true; # Automatically Optimise Nix Store on Build
    gc = {
      automatic = true;
      dates = "Friday 12:00";
      options = "--delete-older-than 7d";
    };
  };
  nixpkgs.config = {
    allowUnfree = true;                                  # Allow the installation of unfree packages not included in the open-source license
    # enableParallelBuildingByDefault = true;              # Enable parallel building
    # rocmSupport = true;                                  # Enable ROCm support for AMD GPUs
    # cudaSupport = true;                                  # Enable CUDA Support for Nvidia GPUs
  };

  # Bootloader Configuration
  boot.loader.systemd-boot.enable = true;  # Use systemd-boot as the bootloader
  boot.loader.efi.canTouchEfiVariables = true;  # Allow bootloader to modify EFI variables

  # This value determines the NixOS release from which the default settings for stateful data, like file locations and database versions on your system were taken.
  # It‘s perfectly fine and recommended to leave this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option: (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
