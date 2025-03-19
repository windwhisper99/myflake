{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixos-wsl, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        wsl = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            mainUser = "liribell";
          };
          system = system;
          modules = [
            nixos-wsl.nixosModules.default
            ./modules/wsl.nix

            home-manager.nixosModules.home-manager
            ./modules/based.nix
          ];
        };
      };
    };
}
