{ pkgs, lib, ... }:
{
  programs.caelestia = {
    enable = true;
    settings = {
      apperance = {
        anim.durations.scale = 0.5;
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
          {
            id = "logo";
            enabled = true;
          }
          {
            id = "workspaces";
            enabled = true;
          }
          {
            id = "spacer";
            enabled = true;
          }
          {
            id = "tray";
            enabled = true;
          }
          {
            id = "clock";
            enabled = true;
          }
          {
            id = "statusIcons";
            enabled = true;
          }
          {
            id = "power";
            enabled = true;
          }
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
}
