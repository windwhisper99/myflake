{
  config,
  inputs,
  pkgs,
  isDesktop,
  lib,
  system,
  catppuccin,
  ...
}: let
  basePkgs = with pkgs; [
    fastfetch
    gh # Github CLI
    gitui
    gh-dash
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
    btop

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

    legcord

    blender
    inkscape
    gimp
    inputs.zen-browser.packages.${system}.default
    libreoffice

    usbutils

    bluetui
    overskride # GUI bluetooth manager

    esptool # Serial bootloader for CNC
    arduino-cli
    avrdude

    prusa-slicer
    openscad
    freecad

    imv # Image viewers
    mpv # Video player
    vlc # Video player
  ];
in {
  imports =
    [
      catppuccin.homeModules.catppuccin
      ./home/fish.nix
      ./nvim/nixvim.nix
    ]
    ++ (
      if isDesktop
      then [./home/hyprland.nix]
      else []
    );

  i18n.inputMethod =
    if isDesktop
    then {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-bamboo
        catppuccin-fcitx5
      ];
    }
    else {
      enable = false;
    };

  catppuccin = {
    enable = true;
    flavor = "mocha";

    gtk.enable = true;
    cursors.enable = true;
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
    portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      config.common.default = "";
    };

    mimeApps = {
      enable = true;
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

  # Make sure Nautilus integration works
  services.gnome-keyring.enable = true;

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    userName = "Windwhisper";
    userEmail = "15071144+windwhisper99@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";
    };

    lfs.enable = true;
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

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme" = 1
    '';
    gtk3.extraConfig = {
      "gtk-application-prefer-dark-theme" = 1;
    };
    gtk4.extraConfig = {
      "gtk-application-prefer-dark-theme" = 1;
    };
  };

  services.playerctld.enable = true;

  dconf.enable = true;

  home.stateVersion = "24.11";
}
