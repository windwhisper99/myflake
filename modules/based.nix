{ pkgs, mainUser, inputs, self, isDesktop, nixvim, ... }: {
  users.users.${mainUser} = {
    isNormalUser = true;
    createHome = true;
    home = "/home/${mainUser}";
    initialPassword = "password";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh = { enable = true; };

  system.stateVersion = "24.11";

  security.sudo.wheelNeedsPassword = false;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit inputs;
      inherit self;
      inherit isDesktop;
      inherit nixvim;
    };
    users.${mainUser} = import ./home.nix;
  };
}
