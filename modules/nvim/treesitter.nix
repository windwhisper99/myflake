{ pkgs, ... }: {
  programs.nixvim = {
    plugins.treesitter = {

      enable = true;

      settings = {
        ensureInstalled = "maintained";
        highlight = {
          enable = true;

          additional_vim_regex_highlighting = true;
        };

        indent = {
          enable = true;
          disable = [ "ruby" ];
        };
      };

    };
  };
}
