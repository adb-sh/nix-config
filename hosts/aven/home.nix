{ ... }:
{
  imports = [
    ../../modules/home
  ];

  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1, 2880x1920@120, 0x0, 1.25"
    ", highrr, auto-center-right, 1"
  ];

  catppuccin.accent = "green";

  home.stateVersion = "25.11";
}
