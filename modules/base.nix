{ config, pkgs, lib, options, ... }:
{

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  networking.domain = "net.adb.sh";

  # nixpkgs.config.allowBroken = true;

  environment.systemPackages = with pkgs; [
    acpi # battery stuff
    home-manager # managing homespace and user software
    alsa-utils # audio controll
    pinentry-curses # password entry window required for gpg
    dconf # required by paprefs
    nix-index # indexing nix packages
    wget
    git
    htop
    openssl
    libtool
    glibc
    ranger
    dig
    vim
    iftop
    nmap
    tsocks
    bat
    sshpass
    exiftool
    sops
    zip
    gitui
    killall
  ];

  services.tailscale.enable = true;
}
