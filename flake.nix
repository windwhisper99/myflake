{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.wallpapers = pkgs.stdenv.mkDerivation {
        name = "my-wallpapers";
        src = ././images;
        installPhase = ''
          mkdir -p $out
          cp -r * $out
        '';
      };

      nixosConfigurations = {
        wsl = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit self;
            mainUser = "liribell";
            isDesktop = false;
          };
          system = system;
          modules = [
            nixos-wsl.nixosModules.default
            ./modules/wsl.nix

            home-manager.nixosModules.home-manager
            ./modules/based.nix
          ];
        };

        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit self;
            mainUser = "liribell";
            isDesktop = true;
          };
          system = system;
          modules = [
            ./hardware-configuration.nix
            home-manager.nixosModules.home-manager
            ./modules/based.nix
            ./modules/nixos.nix
          ];
        };
      };
    };
}
