{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./cmp.nix
    ./lsp.nix
    ./telescope.nix
    ./treesitter.nix
    ./conform.nix
    ./mini.nix
    ./neotest.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;
    colorschemes.gruvbox.enable = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;
    };

    clipboard = {
      providers = {
        wl-copy.enable = true; # For wayland
        xsel.enable = true; # For X11
      };

      register = "unnamedplus";
    };

    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 4;
      tabstop = 4;
      conceallevel = 1;

      mouse = "a";
      showmode = false;

      # Save undo history
      undofile = true;

      # Case-insensitive searching UNLESS \C or one or more capital letters in search term
      ignorecase = true;
      smartcase = true;

      # Keep signcolumn on by default
      signcolumn = "yes";

      # Decrease update time
      updatetime = 250;

      # Decrease mapped sequence wait time
      # Displays which-key popup sonner
      timeoutlen = 300;

      # Configuration how new splits should be opened
      splitright = true;
      splitbelow = true;

      list = true;
      listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";

      # Show which line cursor is on
      cursorline = true;

      # Minimal number of screen lines to keep above and below the cursor
      scrolloff = 10;

      hlsearch = true;
    };

    keymaps = [
      # Clear highlights on search when pressing <Esc> in normal mode
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
      }

      # Window creation
      {
        mode = "n";
        key = "<leader>|";
        action = "<C-w>v";
      }
      {
        mode = "n";
        key = "<leader>-";
        action = "<C-w>s";
      }
      # Delete window
      {
        mode = "n";
        key = "<leader>wd";
        action = "<C-w>c";
      }
      # Windows navigator
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
      }
    ];

    plugins = {
      # Adds icons for plugins to ultilize in ui
      web-devicons.enable = true;

      # Detect tabstop and shiftwidth automatically
      sleuth = {enable = true;};

      # Highlight todo, notes, etc in comments
      todo-comments = {
        settings = {
          enable = true;
          signs = true;
        };
      };

      auto-save = {
        enable = true;
        settings.enabled = true;
      };

      emmet = {enable = true;};

      indent-blankline = {enable = true;};

      harpoon = {enable = true;};

      gitsigns = {
        enable = true;
        settings = {
          signs = {
            add = {text = "+";};
            change = {text = "~";};
            delete = {text = "_";};
            topdelete = {text = "‾";};
            changedelete = {text = "~";};
          };
        };
      };

      tmux-navigator = {enable = true;};

      # Copilot
      copilot-chat = {enable = true;};
      copilot-cmp = {enable = true;};

      ts-autotag = {enable = true;};
      ts-comments = {enable = true;};
      ts-context-commentstring = {enable = true;};

      image = {
        enable = true;
        settings = {
          backend = "kitty";
          # max_height = 12;
          # max_height_window_percentage = {
          #   __raw = "math.huge";
          # };
          max_height_window_percentage = 50;
          # max_width = 100;
          # max_width_window_percentage = {
          #   __raw = "math.huge";
          # };
          window_overlap_clear_enabled = false;
          window_overlap_clear_ft_ignore = [
            "cmp_menu"
            "cmp_docs"
          ];
          editor_only_render_when_focused = false;
          tmux_show_only_in_active_window = false;
          hijack_file_patterns = ["*.png" "*.jpg" "*.jpeg" "*.gif" "*.webp" "*.avif"]; # render image files as images when opened

          markdown = {
            enabled = true;
            filetypes = ["markdown" "vimwiki"];
          };
          neorg = {
            enabled = true;
            filetypes = ["norg"];
          };
          typst = {
            enabled = true;
            filetypes = ["typst"];
          };
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      # Useful for getting pretty icons, but requires a Nerd Font.
      nvim-web-devicons
    ];

    extraConfigLuaPre = ''
      if vim.g.have_nerd_font then
        require('nvim-web-devicons').setup {}
      end
    '';

    extraConfigLuaPost = ''
      -- vim: ts=2 sts=2 sw=2 et
    '';
  };
}
