{
  config,
  inputs,
  pkgs,
  isDesktop,
  lib,
  system,
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
    octave
    blender

    # Development
    clang
    clang-tools
    nodejs_22
    pnpm
    cargo
    rustc
    clippy
    just
  ];
  desktopPkgs = with pkgs; [
    # Desktop Application
    vscode
    brave
    discord
    rnote # White board application

    inputs.zen-browser.packages.${system}.default
  ];
in {
  imports =
    [./home/zsh.nix ./nvim/nixvim.nix]
    ++ (
      if isDesktop
      then [./home/hyprland.nix]
      else []
    );

  i18n.inputMethod =
    if isDesktop
    then {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-bamboo
        catppuccin-fcitx5
      ];
    }
    else {
      enabled = null;
    };

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
