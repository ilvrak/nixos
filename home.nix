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
    dbeaver-bin

    # Browsers / UI apps
    google-chrome
    obsidian
    telegram-desktop
    keepassxc
    thunar
    thunar-archive-plugin
    
    # Cloud / sync (Yandex Disk)
    yandex-disk

    # Office
    libreoffice

    # Shells / tools
    powershell
    gopass
    gnupg
    pinentry-curses
    oath-toolkit
    ncdu
    mc
    wl-clipboard
    cliphist
    openconnect
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

}
