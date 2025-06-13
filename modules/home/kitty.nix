{pkgs, ...}: {
  # Terminal
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = 0.7;
      background_blur = 5;
      confirm_os_window_close = 0;

      font_family = "FiraCode Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      font_size = 11.0;
      sync_to_monitor = true;
      window_padding_width = 8;

      cursor_trail = 2;
    };
  };
}
