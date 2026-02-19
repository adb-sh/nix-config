{ pkgs, ... }:
{
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
    };
  };

  services.displayManager = {
    defaultSession = "hyprland";
    cosmic-greeter = {
      enable = true;
      package = pkgs.unstable.cosmic-greeter;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    config = {
      common = {
        default = [ "hyprland" ];
        "org.freedesktop.impl.portal.Secret" = [
          "gnome-keyring"
        ];
      };
    };
  };
  environment.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    NIXOS_OZONE_WL = "1";
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
