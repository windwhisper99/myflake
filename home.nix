{
  config,
  pkgs,
  nvf,
  ...
}: {
  imports = [nvf.homeManagerModules.default];

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
  ];

  programs.nvf = {
    enable = true;

    # theme.enable = true;
    # theme.name = "gruvbox";
    # theme.style = "dark";

    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;

      vim.theme.enable = true;
      vim.theme.name = "gruvbox";
      vim.theme.style = "dark";

      vim.treesitter = {
        enable = true;
        autotagHtml = true;
      };
      vim.lsp = {
        enable = true;
        formatOnSave = true;
      };

      vim.languages = {
        nix = {
          enable = true;
          format.enable = true;
          lsp.enable = true;
        };

        html = {
          enable = true;
          treesitter = {
            enable = true;
            autotagHtml = true;
          };
        };
        ts = {
          enable = true;
          format.enable = true;
          lsp.enable = true;
        };

        rust = {
          enable = true;
          format.enable = true;
          lsp.enable = true;
        };
      };
    };
  };

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

    shellAliases = {cat = "bat";};
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

  home.stateVersion = "24.11";
}
