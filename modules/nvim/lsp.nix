{pkgs, ...}: {
  programs.nixvim = {
    # Allows extra capabilities providied by nvim-cmp
    plugins.cmp-nvim-lsp = {enable = true;};

    # Useful status updates for LSP
    plugins.fidget = {enable = true;};

    plugins.lsp = {
      enable = true;

      servers = {
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        ts_ls = {enable = true;};
        cssls = {enable = true;};
        emmet_ls = {enable = true;};
        clangd = {enable = true;};
        html = {enable = true;};
        tailwindcss = {enable = true;};

        zls = {enable = true;};

        lua_ls = {
          enable = true;
          settings = {completion = {callSnippet = "Replace";};};
        };
      };

      keymaps = {
        # Diagnostic keymaps
        diagnostic = {
          "<leader>q" = {
            mode = "n";
            action = "setloclist";
            desc = "Open diagnostic [Q]uickfix list";
          };
        };

        extra = [
          # Jump to the definition of the word under cursor.
          {
            mode = "n";
            key = "gd";
            action.__raw = "require('telescope.builtin').lsp_definitions";
            options = {desc = "LSP: [G]oto [D]efinition";};
          }
          # Find references for the word under cursor.
          {
            mode = "n";
            key = "gr";
            action.__raw = "require('telescope.builtin').lsp_references";
            options = {desc = "LSP: [G]oto [R]eferences";};
          }
          # Jump to the implementation of the word under cursor.
          {
            mode = "n";
            key = "gI";
            action.__raw = "require('telescope.builtin').lsp_implementations";
            options = {desc = "LSP: [G]oto [I]mplementation";};
          }
          # Jump to the type of the word under cursor.
          {
            mode = "n";
            key = "<leader>D";
            action.__raw = "require('telescope.builtin').lsp_type_definitions";
            options = {desc = "LSP: Type [D]efinition";};
          }
          # Fuzzy find all the symbols in current document.
          {
            mode = "n";
            key = "<leader>ds";
            action.__raw = "require('telescope.builtin').lsp_document_symbols";
            options = {desc = "LSP: [D]ocument [S]ymbols";};
          }
          # Fuzzy find all the symbols in current workspace.
          {
            mode = "n";
            key = "<leader>ws";
            action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
            options = {desc = "LSP: [W]orkspace [S]ymbols";};
          }
        ];

        lspBuf = {
          # Rename the variable under cursor.
          "<leader>rn" = {
            mode = "n";
            action = "rename";
            desc = "LSP: [R]e[n]ame";
          };
          # Execute a code action, usually cursor needs to be on top of an error
          # or a suggestion from your LSP for this to activate.
          "<leader>ca" = {
            mode = "n";
            action = "code_action";
            desc = "LSP: [C]ode [A]ction";
          };
          # WARN: This is not Goto Definition, this is Goto Declaration.
          #  For example, in C this would take to the header.
          "gD" = {
            action = "declaration";
            desc = "LSP: [G]oto [D]eclaration";
          };
        };
      };
    };
  };
}
