{ config, pkgs, ... }:

{
  ########################
  # БАЗОВЫЕ НАСТРОЙКИ
  ########################

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/Moscow";

  # Bootloader (UEFI)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ########################
  # СЕТЬ
  ########################

  # ВАЖНО: hostname задаётся в local.nix, тут НЕ трогаем.
  networking.networkmanager.enable = true;

  ########################
  # ЗВУК / ПЕЧАТЬ / ВИДЕО
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
  # ПАКЕТЫ СИСТЕМЫ
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
  # ДРУГОЕ
  ########################

  # ВАЖНО: пользователей здесь НЕ описываем, только в local.nix.
  # Это облегчает хранение конфигов в публичном GitHub.

  system.stateVersion = "25.05";
}
