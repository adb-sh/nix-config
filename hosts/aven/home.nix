{ ... }:
{
  imports = [
    ../../modules/home
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, 2880x1920@120, 0x0, 1.25"
      "desc:Dell Inc. DELL U4025QW 9QGPF84, highrr, auto-center-right, 1"
      # "desc:Dell Inc. DELL U4025QW 9QGPF84, 1024x2160@120, auto-center-right, 1"
      ", preferred, auto-center-right, 1"
    ];
    workspace = [
      "2, monitor:desc:Dell Inc. DELL U4025QW 9QGPF84, on-created-empty:firefox"
      "3, monitor:desc:Dell Inc. DELL U4025QW 9QGPF84, on-created-empty:zeditor"
      "4, monitor:desc:Dell Inc. DELL U4025QW 9QGPF84"
      "5, monitor:desc:Dell Inc. DELL U4025QW 9QGPF84"
    ];
  };

  catppuccin.accent = "green";

  home.stateVersion = "25.11";
}
