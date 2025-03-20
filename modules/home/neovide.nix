{ pkgs, ... }: {
  programs.neovide = {
    enable = true;
    settings = {
      theme = "auto";
      title-hidden = true;
      vsync = true;
      wsl = false;
      maximized = false;
      no-multigrid = false;
      srgb = false;

      font = {
        normal = [ "FiraCode Nerd Font" ];
        size = 14.0;
      };
    };
  };
}
