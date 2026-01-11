{ config, pkgs, ... }:

{
  ########################
  # BASIC SETTINGS
  ########################

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/Moscow";

  # Bootloader (UEFI)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ########################
  # NETWORK
  ########################

  # Hostname is defined in local.nix
  networking.networkmanager.enable = true;

  ########################
  # AUDIO / VIDEO / PRINTING
  ########################

  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.printing.enable = true;

  hardware.opengl.enable = true;
  programs.xwayland.enable = true;

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
    kitty          # terminal
    waybar
    rofi-wayland
    wl-clipboard
    htop
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
