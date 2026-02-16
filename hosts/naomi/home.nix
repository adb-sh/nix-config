{ ... }:
{
  imports = [
    ../../modules/home
  ];

  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1, 1920x1080@60, 0x0, 1"
    "DP-1, 5120x2160@60, auto-center-right, 1"
  ];

  catppuccin.accent = "mauve";

  home.stateVersion = "23.05";
}
