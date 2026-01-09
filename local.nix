{ config, pkgs, ... }:

{
  ########################
  # ХОСТ / ПОЛЬЗОВАТЕЛЬ
  ########################

  # ТУТ ВПИСЫВАЕШЬ СВОЁ:
  networking.hostName = "МоёИмяХоста";  # например "laptop" или что захочешь

  users.users."МойЮзер" = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    initialPassword = "временныйПароль";  # потом сменишь через passwd
  };

  ########################
  # ФАЙЛОВЫЕ СИСТЕМЫ
  ########################

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_ROOT";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXOS_BOOT";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/NIXOS_HOME";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/dev/disk/by-label/NIXOS_SWAP"; }
  ];
}
