{ config, pkgs, lib, options, ... }:
{

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowBroken = true;

  environment.sessionVariables = { GTK_THEME = "Adwaita:dark"; };

  services = {
    accounts-daemon.enable = true;
    printing.enable = true;
    illum.enable = true;
    yubikey-agent.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
    gnome.gnome-keyring.enable = true;
  };

  fonts.fontconfig = {
    enable = true;
  };

  fonts.packages = with pkgs; [
    dejavu_fonts
    font-awesome
    font-awesome_5
    nerdfonts
  ];

  environment.systemPackages = with pkgs; [
    acpi # battery stuff
    home-manager # managing homespace and user software
    alsa-utils # audio controll
    pinentry # password entry window required for gpg
    dconf # required by paprefs
    nix-index # indexing nix packages
    wget
    git
    htop
    openssl
    libtool
    glibc
    firefox
    signal-desktop
    element-desktop
    libreoffice
    kitty
    gnome.nautilus
    gparted
    ranger
    maim
    xclip
    dig
    vim
    iftop
    gimp
    inkscape
    nmap
    tsocks
    bat
    sshpass
    exiftool
    gnome.gnome-disk-utility
    gnome.geary
    evince

    # lutrisgnome.geary
    # wine
    # wine-wayland
    # winePackages.full

    slurp # screenshotting
    grim # screenshotting

    termusic # nice music player
    spotify
    parsec-bin

    # different common fonts for icons 
    dejavu_fonts
    font-awesome
    font-awesome_5
    unicode-emoji

    # audio foo
    pulsemixer
    blueberry

    # development
    vscode
    gcc
    okular
    sops
    # gnome-keysign
    gnome.seahorse
  ];

  environment.shellInit = ''export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
  '';

  programs = {
    mosh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    ssh = {
      startAgent = false;
    };
  };

  services.tailscale.enable = true;
  services.flatpak.enable = true;
}
