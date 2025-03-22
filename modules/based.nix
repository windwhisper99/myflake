{
  pkgs,
  mainUser,
  inputs,
  system,
  self,
  isDesktop,
  ...
}: {
  users.users.${mainUser} = {
    isNormalUser = true;
    createHome = true;
    home = "/home/${mainUser}";
    initialPassword = "password";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.zsh = {enable = true;};

  system.stateVersion = "24.11";

  security.sudo.wheelNeedsPassword = false;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit inputs;
      inherit self;
      inherit system;
      inherit isDesktop;
    };
    users.${mainUser} = import ./home.nix;
  };
}
