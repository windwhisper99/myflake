{ config, inputs, pkgs, isDesktop, lib, ... }:
let
  basePkgs = with pkgs; [
    fastfetch
    nnn
    gh # Github CLI

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    nixfmt-classic
    ripgrep
    jq
    yq-go
    bat # cat alternative
    eza # ls alternative
    fzf

    # Development
    clang
    rustup
    nodejs_22
    pnpm
  ];
  desktopPkgs = with pkgs; [
    # Desktop Application
    vscode
    brave
    discord
  ];
in {
  imports = [ ./home/nvim.nix ./home/zsh.nix ]
    ++ (if isDesktop then [ ./home/hyprland.nix ./home/neovide.nix ] else [ ]);

  home.packages = basePkgs ++ (if isDesktop then desktopPkgs else [ ]);

  programs.git = {
    enable = true;
    userName = "Windwhisper";
    userEmail = "15071144+windwhisper99@users.noreply.github.com";
  };

  home.stateVersion = "24.11";
}
