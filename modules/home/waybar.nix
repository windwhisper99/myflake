{pkgs, ...}: let
  config = import ./hyprland-config.nix;
in {
  programs.waybar = {
    enable = true;
    # style = builtins.readFile ./waybar.css;
    settings = {
      main-bar = {
        layer = "top";
        position = "top";
        height = 16;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;

        modules-left = ["hyprland/workspaces"];
        # modules-center = ["hyprland/window"];
        modules-right = [
          "tray"
          "custom/separator"
          "pulseaudio"
          "clock"
          "custom/separator"
          "cpu"
          "memory"
          "custom/space"
        ];

        "custom/separator" = {format = "{} ┃ {}";};
        "custom/space" = {format = "{} ";};

        cpu = {
          tooltip = false;
          format = "󰻠 {usage}%";
          format-alt = "󰻠 {avg_frequency} GHz";
          interval = 5;
        };

        memory = {
          tooltip = false;
          format = "󰍛 {}%";
          format-alt = "󰍛 {used}/{total} GiB";
          interval = 5;
        };

        tray = {
          icon-size = 17;
          spacing = 6;
        };

        clock = {format = " {:%I:%M %p   %a %d}";};

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
          active-only = true;
          disable-scroll = true;
          all-outputs = false;
          on-click = "activate";
          format = "{icon} {name}";
          format-icons = {
            urgent = "";
            active = "";
            default = "󰧞";
            sort-by-number = true;
          };
        };
      };
    };
  };
}
