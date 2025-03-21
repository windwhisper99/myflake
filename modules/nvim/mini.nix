{ pkgs, ... }: {
  programs.nixvim = {
    plugins.mini = {
      enable = true;

      modules = {
        ai = { n_lines = 500; };
        surround = { };
        pairs = { };
        move = { };

        comment = {
          mappings = {
            comment = "gc";
            comment_line = "gc";
            comment_visual = "gc";
            textobject = "gc";
          };
        };

        statusline = { use_icons.__raw = "vim.g.have_nerd_font"; };
        tabline = { show_icons.__raw = "vim.g.have_nerd_font"; };
        bracketed = { };
        files = { };
      };
    };

    extraConfigLua = ''
      require('mini.statusline').section_location = function()
        return '%2l:%-2v'
      end
    '';
  };
}
