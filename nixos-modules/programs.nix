{ config, pkgs, ... }:

let
  # Import AAGL Nix Modules
  aagl-gtk-on-nix = import (builtins.fetchTarball "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz");
in
{

  # Special Program Enablement
  programs.dconf.enable = true;                                         # dconf Editor
  programs.gamemode.enable = true;                                      # GameMode
  programs.partition-manager.enable = true;                             # Partition Manager
  programs.direnv = {
      enable = true;
      nix-direnv.enable = true;                                         # Nix Shell and Environment Direnv Management
  };

  # Steam Program Settings
  programs.steam = { 
    enable = true;
    remotePlay.openFirewall = true;                                     # Open ports in the firewall for Steam Remote Play
    #dedicatedServer.openFirewall = true;                               # Allow the running of dedicated servers within Steam
  };
  
  # AAGL Related Programs ( true = enable; false = disable)
  imports = 
    [ aagl-gtk-on-nix.module ]; 
  programs.anime-game-launcher.enable = true;
  programs.anime-borb-launcher.enable = false;
  programs.honkers-railway-launcher.enable = true;
  programs.honkers-launcher.enable = false;

  # Shell Related
  programs = {
    fish.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;                                             # Set Neovim as Default $EDITOR
      vimAlias = true;
    };
    git = {
      enable = true;
      lfs = {
        enable = true;
      };
    };
  };

  # Hyprland Program Settings
  programs.hyprland = {
    enable = true;
    nvidiaPatches = false;                                             # Switch to true if using Nvidia
    xwayland.enable = true;
  };
  
}
