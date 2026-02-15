{ pkgs, lib, ... }: {
  home.stateVersion = "23.05";
  programs = {
    k9s.enable = true;
    kitty.enable = true;
    obs-studio.enable = true;
    zed-editor.enable = true;
    freetube.enable = true;
    swaylock.enable = true;
  };
  catppuccin = {
    enable = true;
    accent = "green";
    cursors.enable = true;
  };
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
          opacity = .6;
          "col.active" = "$surface0";
          "col.focused" = "$base";
          "col.inactive" = "$mantle";
          "col.active.border" = "$accent";
          "col.focused.border" = "$accent";
        };
      };
      monitor = [
        "eDP-1, 2880x1920@120, 0x0, 1.33"
        ", highrr, auto-center-right, 1"
      ];
      general = {
        layout = "hy3";
        resize_on_border = true;
        gaps_in = 4;
        gaps_out = 0;
        border_size = 2;
        "col.active_border" = "$accent";
        "col.inactive_border" = "$surface1";
        # todo: add backgroud color
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
        "$mod, l, exec, caelestia-shell ipc call ipc call lock lock"
        # open launcher
        "$mod, slash, exec, caelestia-shell ipc call drawers toggle launcher"

        # scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e-1"
        "$mod, mouse_up, workspace, e+1"

        # tab through existing workspaces
        "$mod, TAB, workspace, e+1"
        "$mod SHIFT, TAB, workspace, e-1"

        # move window
        # "$mod ALT SHIFT, down, movetoworkspace, e+1"
        # "$mod ALT SHIFT, up, movetoworkspace, e-1"

        # group / split
        "$mod, v, hy3:makegroup, h"
        "$mod, b, hy3:makegroup, v"
        "$mod SHIFT, t, hy3:makegroup, tab"

        # layout switching
        "$mod, s, hy3:changegroup, stacked"
        "$mod, w, hy3:changegroup, tab"
        "$mod, e, hy3:changegroup, opposite"

        # classic window controls
        "$mod SHIFT, q, killactive"
        "$mod, f, fullscreen"
        "$mod, space, togglefloating"

        # shortcuts
        "$mod, Return, exec, kitty"

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
      ] ++ (
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9)
      );
    };
  };

  programs.caelestia = {
    enable = true;
    settings = {
      apperance = {
        anim.durations.scale = .5;
        font.family = {
          mono = "FiraCode Nerd Font";
          sans = "0xProto Nerd Font";
          clock = "0xProto Nerd Font";
          material = "Material Symbols Rounded";
        };
      };
      bar = {
        status = {
          showBattery = true;
        };
        entries = [
          {id = "logo"; enabled = true;}
          {id = "workspaces"; enabled = true;}
          {id = "spacer"; enabled = true;}
          {id = "tray"; enabled = true;}
          {id = "clock"; enabled = true;}
          {id = "statusIcons"; enabled = true;}
          {id = "power"; enabled = true;}
        ];
        workspaces = {
          activeIndicator = true;
          activeLabel = "󰮯";
          activeTrail = false;
          label = "●";
          occupiedBg = false;
          occupiedLabel = "_";
          perMonitorWorkspaces = true;
          showWindows = true;
          shown = 5;
        };
      };
      border = {
        thickness = 8;
        rounding = 12;
      };
      notifs = {
        actionOnClick = true;
        openExpanded = true;
      };
      services = {
        useFahrenheit = false;
        useTwelveHourClock = false;
      };
      background = {
        enabled = true;
        desktopClock.enabled = true;
      };
    };
  };

  programs.zed-editor = {
    # enable = true;

    extensions = [
      "nix"
      "toml"
      "gleam"
      "kotlin"
    ];

    # settings.json rendered by HM
    userSettings = {
      # tell Zed which LSP to use for Kotlin
      languages = {
        # "Kotlin" = {
        #   language_servers = [ "kotlin-language-server" ];
        # };
      };

      # point Zed at the correct LSP binary
      lsp = {
        rust-analyzer = {
          initialization_options = {
            diagnostics = {
              enable = true;
            };
          };
          binary = {
            path = lib.getExe pkgs.rust-analyzer;
            # path_lookup = true;
          };
        };
        "kotlin-language-server" = {
          binary = {
            path =  lib.getExe pkgs.kotlin-language-server;
          };
          binary.env = {
            JAVA_HOME = "${pkgs.jdk17}";
          };
        };
      };
    };
  };
}
