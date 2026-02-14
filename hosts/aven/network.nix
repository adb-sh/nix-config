{ pkgs, modulesPath, lib, ... }: {
  networking.networkmanager.enable = true;
  # networking.useDHCP = true;
}
