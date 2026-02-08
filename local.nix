{ config, pkgs, ... }:

let
  # CHANGE THESE LOCALLY
  userName = "ilvrak";
  hostName = "nixos-laptop";
in
{
  ########################
  # HOSTNAME / USER
  ########################

  networking.hostName = hostName;

  users.users.${userName} = {
    isNormalUser = true;
    extraGroups  = [ "wheel" "networkmanager" "docker" ];
    initialPassword = "******";  # change after first login with `passwd`
  };

  ########################
  # HOME MANAGER USER
  ########################

  home-manager.users.${userName} = import ./home.nix;
}
