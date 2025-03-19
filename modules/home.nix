{ config, pkgs, ... }: {
  imports = [ ./nvim.nix ];

  home.packages = with pkgs; [
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

  programs.git = {
    enable = true;
    userName = "Windwhisper";
    userEmail = "15071144+windwhisper99@users.noreply.github.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = { cat = "bat"; };
    history.size = 10000;

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "zdharma-continuum/fast-syntax-highlighting"; }
        { name = "MichaelAquilina/zsh-you-should-use"; }
        { name = "Aloxaf/fzf-tab"; }
        { name = "jeffreytse/zsh-vi-mode"; }
      ];
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "eza" "fzf" ];
      theme = "avit";
    };
  };

  home.stateVersion = "24.11";
}
