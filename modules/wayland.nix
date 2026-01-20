{ pkgs, config, lib, ... }: {
  programs = {
    xwayland.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        # swaylock-fancy
        swayidle
        wl-clipboard
        mako
        alacritty
        wofi
        wofi-emoji
        adwaita-icon-theme
        i3status-rust
        swayr
        dmenu
        #dmenu-wayland
        xdg-desktop-portal-wlr
        polkit
        polkit_gnome
        lxsession
      ];
    };
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  environment.etc."sway/config".source = lib.mkForce (pkgs.callPackage ./build-sway-config.nix { });

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
    };
  };

  services.displayManager = {
    defaultSession = "sway";
    ly.enable = true;
  };

  environment.systemPackages = [
    pkgs.xdg-desktop-portal-wlr
    pkgs.hyprlandPlugins.hy3
  ];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  security.polkit.enable = true;

  systemd.services.polkit-gnome-authentication-agent-1 = {
    enable = true;
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
