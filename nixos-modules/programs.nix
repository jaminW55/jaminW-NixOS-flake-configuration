{ config, pkgs, ... }:

{
  # Special Program Enablement
  programs.dconf.enable = true; # dconf Editor
  programs.gamemode.enable = true; # GameMode
  programs.partition-manager.enable = true; # Partition Manager
  programs.fish.enable = true; # Fish Shell

  # Steam Program Settings
  programs.steam = { 
    # Configuration for the Steam Program
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  };
  
  # AAGL Related Programs ( true = enable; false = disable)
  programs.anime-game-launcher.enable = true;
  programs.anime-borb-launcher.enable = false;
  programs.honkers-railway-launcher.enable = true;
  programs.honkers-launcher.enable = false;

  # Hyprland Program Settings
  programs.hyprland = {
    enable = true;
    nvidiaPatches = false; # Switch to true if using Nvidia
    xwayland.enable = true;
  };

  # Enable Nix Flakes
  nix.extraOptions = "experimental-features = nix-command flakes";

  # ... any other program configurations ...
  
}