{ pkgs, lib, ... }: {
  home.stateVersion = "23.05";
  programs = {
    k9s.enable = true;
    kitty.enable = true;
    obs-studio.enable = true;
    zed-editor.enable = true;
    freetube.enable = true;
  };
  # wayland.windowManager.sway.enable = true; # todo
  catppuccin = {
    enable = true;
    accent = "sky";
    cursors.enable = true;
  };
}
