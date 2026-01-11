{ config, pkgs, ... }:

{
  ########################
  # HOME MANAGER BASICS
  ########################

  # These are user-level configs; username/homeDirectory are set in local.nix
  home.stateVersion = "25.05";

  ########################
  # USER PACKAGES
  ########################

  home.packages = with pkgs; [
    # Dev / automation
    ansible
    python3
    vscode
    dbeaver       # DB GUI (can swap later)

    # Browsers / UI apps
    chromium
    obsidian
    telegram-desktop
    keepassxc

    # Cloud / sync (Yandex Disk)
    yandex-disk

    # Office
    freeoffice

    # Shells / tools
    powershell
    mc
  ];

  ########################
  # PROGRAMS
  ########################

  programs.git.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -alF";
      gs = "git status";
      k  = "kubectl";
    };
  };

  programs.starship.enable = true;

  # Kitty is installed system-wide, but можно добавить конфиги позже через xdg.configFile
}
