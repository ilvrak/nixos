{ config, pkgs, ... }:

{
  ########################
  # BASIC SETTINGS
  ########################

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Moscow";

  # Bootloader (UEFI)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ########################
  # NETWORK
  ########################

  # Hostname is defined in local.nix
  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = [];

  ########################
  # AUDIO / VIDEO / PRINTING
  ########################

  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.printing.enable = true;

  hardware.graphics.enable = true;
  programs.xwayland.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  ########################
  # Hyprland + SDDM
  ########################

  programs.hyprland.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  ########################
  # SYSTEM PACKAGES
  ########################

  environment.systemPackages = with pkgs; [
    git
    vim
    alacritty
    waybar
    wofi
    wl-clipboard
    htop
    wget
    networkmanagerapplet
    networkmanager
    blueman
    bluez
    bluez-tools
    hyprlauncher
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  ########################
  # STEAM / DOCKER
  ########################

  programs.steam.enable = true;

  virtualisation.docker.enable = true;

  ########################
  # MISC
  ########################

  # Users are defined in local.nix (hostname, username, password).
  # Do NOT add users here, to keep GitHub config generic.

  system.stateVersion = "25.05";
}
