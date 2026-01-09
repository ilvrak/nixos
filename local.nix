{ config, pkgs, ... }:

{
  ########################
  # HOSTNAME / USER
  ########################

  # Set your own values here:
  networking.hostName = "my-laptop";  # change to whatever you want

  users.users."myuser" = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    # Temporary password, change it after first login with `passwd`.
    initialPassword = "changeme123";
  };

  ########################
  # FILESYSTEMS (MATCH DISK LABELS)
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
