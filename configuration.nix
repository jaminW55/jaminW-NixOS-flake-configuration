# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  aagl-gtk-on-nix = import (builtins.fetchTarball "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz");
  gazou = pkgs.callPackage "/home/jaminW55/Documents/Nix Packages/Gazou Nix/gazou.nix" {};
  # manjiDict = pkgs.callPackage "/home/jaminW5/Documents/Nix Packages/Manji Dict/manjiDict.nix" {};
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # AAGL Launcher
      aagl-gtk-on-nix.module
    ];

  #AAGL Related Programs
  programs.anime-game-launcher.enable = true;
  programs.anime-borb-launcher.enable = false;
  programs.honkers-railway-launcher.enable = true;
  programs.honkers-launcher.enable = false;

  nix.settings = {
    substituters = [ "https://ezkea.cachix.org" ];
    trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "AMDnixOS"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
          fcitx5-mozc
          fcitx5-gtk
      ];
  };

  environment.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    QT_IM_MODULE = "fcitx";
    GTK_IM_MODULE = "fcitx";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    source-han-sans-japanese
    source-han-serif-japanese
  ];

  # List services that you want to enable:

  # Enable Samba
  # services.samba.enableWinbindd = true;

  # Enable OpenSSH
  services.openssh.enable = true;

  # Enable X11 Windowing System
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Enable the Plasma 5 Desktop Environment
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jaminW55 = {
    isNormalUser = true;
    description = "jaminW";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };
  programs.fish.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alsa-utils
    anki
    brave
    btop
    citra-canary
    discord
    direnv # vscode extension
    # distrobox
    firefox
    fish
    gazou
    gimp
    git
    gnutls
    kate
    komikku
    libsForQt5.kcalc
    libsForQt5.kolourpaint
    # libsForQt5.kmail
    # libsForQt5.kwalletmanager
    lutris
    mangohud
    # manjiDict
    neofetch
    nvtop-amd
    obs-studio
    obsidian
    onlyoffice-bin
    pciutils
    protonup-qt
    telegram-desktop
    thunderbird
    vim
    vlc
    vscode
    winetricks
    wineWowPackages.stable
    xdg-user-dirs
    xivlauncher
    # xorg.xhost
    yuzu-mainline
    zoom-us
    zotero
  ];

  # Special Program Enablement
  programs.dconf.enable = true;
  programs.gamemode.enable = true;
  programs.partition-manager.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  };

  #Services Disabled
  services.flatpak.enable = false;

    # virtualisation = {
  #   podman = {
  #     enable = true;

  #     # Create a `docker` alias for podman, to use it as a drop-in replacement
  #     dockerCompat = true;

  #     # Required for containers under podman-compose to be able to talk to each other.
  #     defaultNetwork.settings.dns_enabled = true;
  #     # For Nixos version > 22.11
  #     #defaultNetwork.settings = {
  #     #  dns_enabled = true;
  #     #};
  #   };
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default settings for stateful data, like file locations and database versions on your system were taken.
  # It‘s perfectly fine and recommended to leave this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option: (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}