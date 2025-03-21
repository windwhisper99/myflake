{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      cat = "bat";
      q = "exit";
    };
    history.size = 10000;

    zplug = {
      enable = true;
      plugins = [
        {name = "zsh-users/zsh-autosuggestions";}
        {name = "zsh-users/zsh-completions";}
        {name = "zsh-users/zsh-history-substring-search";}
        {name = "zdharma-continuum/fast-syntax-highlighting";}
        {name = "MichaelAquilina/zsh-you-should-use";}
        {name = "Aloxaf/fzf-tab";}
        {name = "jeffreytse/zsh-vi-mode";}
      ];
    };
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "eza" "fzf"];
      theme = "avit";
    };
  };

  programs.tmux = {
    enable = true;
    escapeTime = 0;
    # Start with 1
    baseIndex = 1;
    keyMode = "vi";

    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
    ];
  };
}
