{pkgs, ...}: {
  programs.nixvim = {
    plugins.mini = {
      enable = true;

      modules = {
        ai = {n_lines = 500;};
        surround = {};
        pairs = {};

        comment = {
          mappings = {
            comment = "gc";
            comment_line = "gc";
            comment_visual = "gc";
            textobject = "gc";
          };
        };

        icons = {};

        statusline = {use_icons.__raw = "vim.g.have_nerd_font";};
        tabline = {show_icons = true;};
        bracketed = {};
        files = {};
      };
    };

    keymaps = [
      # Clear highlights on search when pressing <Esc> in normal mode
      {
        mode = "n";
        key = "<leader>e";
        action.__raw = "MiniFiles.open";
      }
    ];

    extraConfigLua = ''
      require('mini.statusline').section_location = function()
        return '%2l:%-2v'
      end
    '';
  };
}
