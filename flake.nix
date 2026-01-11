{
  description = "NixOS laptop with Hyprland and Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, hyprland, home-manager, ... }: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./hardware-configuration.nix
        ./configuration.nix   # common NixOS config
        ./local.nix           # local override (hostname, user, password)

        # Home Manager as a NixOS module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # The actual user will be defined in local.nix,
          # so we only enable HM here, user mapping also in local.nix.
        }
      ];
    };
  };
}
