{ pkgs, ... }: {

  programs.nixvim = {
    plugins.cmp = {
      enable = true;

      settings = {
        snippet = {
          expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
        };

        mapping = {
          # Select the [n]ext item
          "<C-n>" = "cmp.mapping.select_next_item()";
          # Select the [p]revious item
          "<C-p>" = "cmp.mapping.select_prev_item()";
          # Scroll the documentation window [b]ack / [f]orward
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          # Accept ([y]es) the completion.
          #  This will auto-import if your LSP supports it.
          #  This will expand snippets if the LSP sent a snippet.
          "<C-y>" = "cmp.mapping.confirm { select = true }";
          # Classic enter to accept the completion
          "<CR>" = "cmp.mapping.confirm { select = true }";

          # Manually trigger a completion from nvim-cmp.
          "<C-Space>" = "cmp.mapping.complete {}";
          # Shift tab to close the completion
          "<S-Tab>" = "cmp.mapping.close()";

          # <C-l> to move to the right of the expansion locations.
          # <C-h> to move back
          "<C-l>" = ''
            cmp.mapping(function()
              if require("luasnip").expand_or_locally_jumpable() then
                require("luasnip").expand_or_jump()
              end
            end, { 'i', 's' })
          '';
          "<C-h>" = ''
            cmp.mapping(function()
              if require("luasnip").locally_jumpable(-1) then
                require("luasnip").jump(-1)
              end
            end, { 'i', 's' })
          '';
        };

        completion = { completeopt = "menu,menuone,noinsert"; };
        sources = [
          { name = "luasnip"; }
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "emoji"; }
          { name = "calc"; }
        ];
      };
    };
  };

}
