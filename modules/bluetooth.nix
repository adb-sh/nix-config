{ pkgs, config, lib, ... }: {
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
  };

  services.blueman.enable = true;
}
