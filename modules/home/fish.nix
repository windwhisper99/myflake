{pkgs, ...}: {
  programs.fish = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.tmux = {
    enable = true;
    escapeTime = 0;
    # Start with 1
    baseIndex = 1;
    keyMode = "vi";

    shortcut = "s";

    extraConfig = "set -gq allow-passthrough on\nset -g visual-activity off";

    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
    ];
  };
}
