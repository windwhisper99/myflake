{ pkgs, ... }: {
  programs.neovim = {
    enable = true;

    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      gruvbox-nvim
      neodev-nvim

      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp

      nvim-web-devicons

      mini-ai
      mini-pairs
      mini-comment
      mini-surround
      mini-files

      rustaceanvim

      (nvim-treesitter.withPlugins
        (p: [ p.tree-sitter-nix p.tree-sitter-rust ]))
    ];
  };
}
