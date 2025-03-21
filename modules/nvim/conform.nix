# https://github.com/stevearc/conform.nvim/
{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = with pkgs; [
      # Format for nix
      alejandra
      # Format for lua
      stylua
      # Format for Rust
      rustfmt

      # prettierd
      # Support multiple language
      prettierd
    ];

    plugins.conform-nvim = {
      enable = true;

      settings = {
        notify_on_error = false;
        format_on_save = ''
          function(bufnr)
            -- Disable "format_on_save lsp_fallback" for lanuages that don't
            -- have a well standardized coding style. You can add additional
            -- lanuages here or re-enable it for the disabled ones.
            local disable_filetypes = { }
            return {
              timeout_ms = 500,
              lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype]
            }
          end
        '';
        formatters_by_ft = {
          nix = ["alejandra"];
          lua = ["stylua"];
          rust = ["rustfmt"];

          javascript = ["prettierd"];
          typescript = ["prettierd"];
          html = ["prettierd"];
          css = ["prettierd"];
          json = ["prettierd"];
          yaml = ["prettierd"];
          graphql = ["prettierd"];
          vue = ["prettierd"];

          c = ["clang-format"];
          cpp = ["clang-format"];
        };
      };
    };

    keymaps = [
      {
        mode = "";
        key = "<leader>f";
        action.__raw = ''
          function()
            require('conform').format { async = true, lsp_fallback = true }
          end
        '';
        options = {desc = "[F]ormat buffer";};
      }
    ];
  };
}
