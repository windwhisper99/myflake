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
    gh # Github CLI
    lazygit
    tig # Git TUI
    pavucontrol
    awscli2

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
    ffmpeg # Video converter
    imagemagick # Image converter

    # Development
    clang
    clang-tools
    nodejs_22
    pnpm
    cargo
    rustc
    zig
    clippy
    just

    obsidian

    # Games
    solitaire-tui
  ];
  desktopPkgs = with pkgs; [
    # Desktop Application
    vscode
    brave
    discord
    blender
    inkscape
    gimp
    kdePackages.dolphin
    inputs.zen-browser.packages.${system}.default
    libreoffice

    vimiv-qt # Image viewers
    imv # Image viewers
    mpv # Video player
    vlc # Video player
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
  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  xdg = {
    mimeApps = {
      enable = false;
      defaultApplications = {
        "text/plain" = "nvim.desktop";
        "image/png" = "imv.desktop";
        "image/jpeg" = "imv.desktop";
        "image/jpg" = "imv.desktop";
        "image/gif" = "imv.desktop";
        "image/webp" = "imv.desktop";
        "image/svg+xml" = "imv.desktop";

        "video/mp4" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop"; # For .mov filessktop";

        "application/pdf" = "zathura.desktop";
      };
    };
  };

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    userName = "Windwhisper";
    userEmail = "15071144+windwhisper99@users.noreply.github.com";
  };

  programs.lf = {
    enable = true;

    settings = {
      preview = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };
  };

  home.stateVersion = "24.11";
}
