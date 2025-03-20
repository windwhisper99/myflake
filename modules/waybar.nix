{ pkgs, ... }:
let config = import ./hyprland-config.nix;
in {
  programs.waybar = {
    enable = true;
    settings = {
      main-bar = {
        layer = "top";
        position = "top";
        height = 26;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right =
          [ "clock" "pulseaudio" "network" "cpu" "memory" "tray" ];

        "hyprland/workspaces" = {
          active-only = true;
          disable-scroll = true;
          all-outputs = false;
          warp-on-scroll = false;
          format = "{name} {icon}";
          format-icons = {
            "active" = "";
            "default" = "";
          };
        };
      };
    };
  };
}
