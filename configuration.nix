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

  # Hostname is defined in local.nix, do NOT set it here.
  networking.networkmanager.enable = true;

  ########################
  # AUDIO / PRINTING / VIDEO
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
    git vim
    kitty waybar rofi-wayland wl-clipboard
    firefox
    vscode.fhs
    steam
    chromium
    obsidian
    ansible
  ];

  programs.steam.enable = true;

  ########################
  # USERS
  ########################

  # Users are defined only in local.nix (not in GitHub).
  # This keeps your hostname / username / password out of the repo.

  system.stateVersion = "25.05";
}
