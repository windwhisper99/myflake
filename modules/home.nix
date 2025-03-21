{
  config,
  inputs,
  pkgs,
  isDesktop,
  lib,
  ...
}: let
  basePkgs = with pkgs; [
    fastfetch
    nnn
    gh # Github CLI
    lazygit
    pavucontrol

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
    clang-tools
    nodejs_22
    pnpm
    cargo
    rustc
    just
  ];
  desktopPkgs = with pkgs; [
    # Desktop Application
    vscode
    brave
    discord
  ];
in {
  imports =
    [./home/zsh.nix ./nvim/nixvim.nix]
    ++ (
      if isDesktop
      then [./home/hyprland.nix]
      else []
    );

  home.packages =
    basePkgs
    ++ (
      if isDesktop
      then desktopPkgs
      else []
    );
  home.sessionVariables = {TERMINAL = "kitty";};

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    userName = "Windwhisper";
    userEmail = "15071144+windwhisper99@users.noreply.github.com";
  };

  home.stateVersion = "24.11";
}
