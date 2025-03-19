

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixos-wsl, home-manager, nvf, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        wsl = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            nixos-wsl.nixosModules.default
            {
              nix.settings.experimental-features = [ "nix-command" "flakes" ];

              programs.zsh.enable = true;
              programs.nix-ld = {
                enable = true;
                package = pkgs.nix-ld-rs;
              };

              users.users.liribell = {
                isNormalUser = true;
                home = "/home/liribell";
                description = "Liri Bell";
                shell = pkgs.zsh;
              };

              wsl.enable = true;
              wsl.defaultUser = "liribell";

              # environment.systemPackages = [ customNeovim.neovim ];
              system.stateVersion = "24.11";
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = { inherit nvf; };
              home-manager.users.liribell = import ./home.nix;
            }
          ];
        };
      };
    };
}
