{pkgs, ...}: let
  config = import ./hyprland-config.nix;
in {
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./waybar.css;
    settings = {
      main-bar = {
        layer = "top";
        position = "top";

        modules-left = ["hyprland/workspaces"];
        modules-center = ["custom/music"];
        modules-right = [
          "pulseaudio"
          "clock"

          "tray"

          "custom/power"
        ];

        tray = {
          icon-size = 20;
          spacing = 10;
        };

        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = " {:%d/%m/%Y}";
          format = " {:%H:%M}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            "alsa_output.pci-0000_00_1f.3.analog-stereo" = "";
            "alsa_output.pci-0000_00_1f.3.analog-stereo-muted" = "";
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            phone-muted = "";
            portable = "";
            car = "";
            default = ["" ""];
          };
          scroll-step = 1;
          on-click = "pavucontrol";
          ignored-sinks = ["Easy Effects Sink"];
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          format = " {name} ";
          format-icons = {
            default = "";
          };
        };

        "custom/music" = {
          format = " {}";
          escape = true;
          interval = 5;
          tooltip = false;
          exec = "playerctl metadata --format='{{title}}'";
          on-click = "playerctl play-pause";
          max-length = 50;
        };

        "custom/power" = {
          tooltip = false;
          on-click = "rofi -show power";
          format = "⏻";
        };
      };
    };
  };
}
