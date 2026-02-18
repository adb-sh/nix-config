{ pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      "${pkgs.hyprlandPlugins.hy3}/lib/libhy3.so"
    ];
    settings = {
      plugin.hy3 = {
        no_gaps_when_only = 1;
        tabs = {
          height = 22;
          padding = 4;
          radius = 8;
          border_width = 2;
          from_top = true;
          blur = false;
          opacity = 0.6;
          # use catpuccin colors
          "col.active" = "$surface0";
          "col.focused" = "$base";
          "col.inactive" = "$mantle";
          "col.active.border" = "$accent";
          "col.focused.border" = "$accent";
        };
      };
      monitor = [ ];
      xwayland = {
        force_zero_scaling = true;
      };
      # env = [
      #   "NIXOS_OZONE_WL,1"
      # ];
      general = {
        layout = "hy3";
        resize_on_border = true;
        gaps_in = 4;
        gaps_out = 4;
        border_size = 2;
        # use catpuccin colors
        "col.active_border" = "$accent";
        "col.inactive_border" = "$surface1";
      };
      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        blur = {
          enabled = true;
          size = 2;
          passes = 4;
        };
      };
      bezier = [
        "easeOutQuint,   0.23, 1,    0.32, 1"
        "easeInOutCubic, 0.65, 0.05, 0.36, 1"
        "linear,         0,    0,    1,    1"
        "almostLinear,   0.5,  0.5,  0.75, 1"
        "quick,          0.15, 0,    0.1,  1"
      ];
      animation = [
        "global, 1, 2, easeOutQuint"
        "workspaces, 1, 2, almostLinear, slidevert"
      ];
      windowrule = [
        "opacity 0.9 override 0.9 override 0.9 override, class:kitty"
        "opacity 0.9 override 0.9 override 0.9 override, class:dev.zed.Zed"
      ];

      "$mod" = "SUPER";
      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
      bindl = [
        # Laptop multimedia keys for volume and LCD brightness
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"

        # Requires playerctl
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
      ];
      bind = [
        # lock screen
        "$mod, l, exec, caelestia-shell ipc call lock lock"

        # open launcher
        "$mod, slash, exec, caelestia-shell ipc call drawers toggle launcher"

        # scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e-1"
        "$mod, mouse_up, workspace, e+1"

        # tab through existing workspaces
        "$mod, TAB, workspace, e+1"
        "$mod SHIFT, TAB, workspace, e-1"

        # group / split
        "$mod, h, hy3:makegroup, h"
        "$mod, v, hy3:makegroup, v"
        "$mod SHIFT, t, hy3:makegroup, tab"

        # layout switching
        "$mod, s, hy3:changegroup, stacked"
        "$mod, w, hy3:changegroup, tab"
        "$mod, e, hy3:changegroup, opposite"

        # classic window controls
        "$mod SHIFT, q, killactive"
        "$mod, f, fullscreen"
        "$mod, space, togglefloating"

        # focus
        "$mod, left,  hy3:movefocus, l"
        "$mod, down,  hy3:movefocus, d"
        "$mod, up,    hy3:movefocus, u"
        "$mod, right, hy3:movefocus, r"

        # move
        "$mod SHIFT, left,  hy3:movewindow, l"
        "$mod SHIFT, down,  hy3:movewindow, d"
        "$mod SHIFT, up,    hy3:movewindow, u"
        "$mod SHIFT, right, hy3:movewindow, r"

        # open kitty
        "$mod, Return, exec, kitty"

        # screenshot
        ", PRINT, exec, ${lib.getExe pkgs.grimblast} copysave area"
      ]
      ++ (
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 9
        )
      );
    };
  };
}
