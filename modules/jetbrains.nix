{ config, pkgs, lib, options, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains.webstorm
    jetbrains.pycharm-professional
    jetbrains.goland
  ];
}
