{
  pkgs,
  self,
  ...
}: let
  hyprland-config = import ./hyprland-config.nix;
in {
  imports = [./waybar.nix ./rofi.nix ./kitty.nix];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$terminal" = "kitty";
      "$appmenu" = "rofi -show drun";
      "$winmenu" = "rofi -show window";
      "$runmenu" = "rofi -show run";
      "$screenshot-region" = "hyprshot -m region --clipboard-only";

      "$mod" = "SUPER";

      exec-once = ["waybar" "hyprpaper"];

      monitor = hyprland-config.monitor;
      device = hyprland-config.device;
      workspace = hyprland-config.workspace;

      general = {
        gaps_in = 3;
        gaps_out = 8;
        border_size = 2;

        "col.active_border" = "rgba(ebdbb2cc) rgba(fbf1c7cc) 45deg";
        "col.inactive_border" = "rgba(3c3836cc) rgba(1d2021cc) 45deg";
        layout = "dwindle";
        resize_on_border = true;
      };

      group = {
        "col.border_active" = "rgba(ebdbb2cc) rgba(fbf1c7cc) 45deg";
        "col.border_inactive" = "rgba(3c3836cc) rgba(1d2021cc) 45deg";
        "col.border_locked_active" = "rgba(ebdbb2cc) rgba(fbf1c7cc) 45deg";
        "col.border_locked_inactive" = "rgba(3c3836cc) rgba(1d2021cc) 45deg";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {new_status = "master";};

      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      decoration = {
        rounding = 10;
        # drop_shadow = false;
        # rounding_power = 2;

        active_opacity = 1.0;
        inactive_opacity = 0.95;

        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = "on";
          ignore_opacity = "on";
          xray = false;
        };
      };

      layerrule = ["blur,waybar" "blur,rofi"];

      bind = [
        # Application
        "$mod, Q, exec, $terminal"
        "$mod, C, killactive,"
        "$mod, R, exec, $runmenu"
        "$mod, A, exec, $appmenu"
        "$mod, W, exec, $winmenu"
        "$mod, M, exit,"
        "$mod, V, toggleFloating,"
        # Screenshot
        "$mod SHIFT, S, exec, $screenshot-region"
        # Lock screen
        "$mod SHIFT, L, exec, hyprlock"

        # Move focus
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # Switch workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"

        # Move active window to a workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
      ];
      bindm = ["$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow"];

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };

  # Utilities applications
  home.packages = with pkgs; [
    # Sound control
    pavucontrol
    alsa-utils

    hyprshot # Screenshot

    self.packages.wallpapers
  ];

  # Screen block
  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        path = "${self.packages.wallpapers}/cat.png";
        color = "rgba(17,17,17,1.0)";
        blur_passes = 3;
        vibrancy_darkness = 0.0;
      };

      general = {
        no_fade_in = false;
        grace = 0;
        disable_loading_bar = false;
      };

      label = [
        # Day Month Date
        {
          text = ''cmd[update:1000] echo -e "$(date + "%A, %B %d")"'';
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 25;
          font_family = "SF Pro Display Bold";
          position = "0, 350";
          halign = "center";
          valign = "center";
        }
        # Time
        {
          text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 120;
          font_family = "SF Pro Display Bold";
          position = "0, 250";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = {
        size = "300, 60";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "rgba(0,0,0,0)";
        inner_color = "rgba(255,255,255,0.1)";
        font_color = "rgb(200,200,200)";
        fade_on_empty = false;
        font_family = "SF Pro Display Bold";
        placeholder_text = ''<i><span foreground="##ffffff99">Enter Pass</span></i>'';
        hide_input = false;
        position = "0, -100";
        halign = "center";
        valign = "center";
      };
    };
  };

  # Screen idle
  services.hypridle = {
    enable = true;
    settings = {
      general = {lock_cmd = "pidof hyprlock || hyprlock";};

      # Lock screen on 5 mins
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
      ];
    };
  };

  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = ["${self.packages.wallpapers}/cat.png"];
      wallpaper = [",${self.packages.wallpapers}/cat.png"];
    };
  };
}
