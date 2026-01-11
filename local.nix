{ config, pkgs, ... }:

let
  # CHANGE THESE LOCALLY
  userName = "myuser";
  hostName = "my-laptop";
in
{
  ########################
  # HOSTNAME / USER
  ########################

  networking.hostName = hostName;

  users.users.${userName} = {
    isNormalUser = true;
    extraGroups  = [ "wheel" "networkmanager" "docker" ];
    initialPassword = "changeme123";  # change after first login with `passwd`
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

  ########################
  # HOME MANAGER USER
  ########################

  home-manager.users.${userName} = import ./home.nix;
}
