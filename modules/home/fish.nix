{pkgs, ...}: {
  programs.fish = {
    enable = true;
    functions = {
      fish_user_key_bindings = "fish_vi_key_bindings";
      fish_greeting = ''
      '';
    };

    shellAbbrs = {
      q = "exit";
      pn = "pnpm";
      cls = "clear";

      # Shortcut for nix
      ns = "sudo nixos-rebuild switch --flake ./#nixos";
      nu = "sudo nix flake update";

      # Rust and Cargo aliases
      c = "cargo";
      cn = "cargo new";
      cr = "cargo run";
      ct = "cargo test";
      cb = "cargo build";
      cc = "cargo clippy";
    };

    plugins = [
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
    ];
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
