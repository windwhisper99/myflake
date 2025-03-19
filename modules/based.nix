{ pkgs, mainUser, ... }: {
  users.users.${mainUser} = {
    isNormalUser = true;
    createHome = true;
    home = "/home/liribell";
    initialPassword = "password";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh = { enable = true; };

  system.stateVersion = "24.11";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${mainUser} = import ./home.nix;
}
