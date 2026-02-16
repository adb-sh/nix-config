{ ... }:
{
  imports = [
    ./caelestia.nix
    ./hyprland.nix
    ./zed.nix
  ];

  programs = {
    kitty.enable = true;
    obs-studio.enable = true;
    freetube.enable = true;
  };
  catppuccin = {
    enable = true;
    cursors.enable = true;
  };
}
