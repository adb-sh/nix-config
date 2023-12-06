{ config, pkgs, lib, options, ... }:
{

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
    "spotify"
  ];

  environment.sessionVariables = { GTK_THEME = "Adwaita:dark"; };

  services = {
    accounts-daemon.enable = true;
    printing.enable = true;
    illum.enable = true;
    yubikey-agent = {
      enable = true;
    };
    udev.packages = [ pkgs.yubikey-personalization ];
  };
  fonts.fontconfig = {
    enable = true;
  };

  fonts.fonts = with pkgs; [
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
    spotify-qt
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

    # lutris
    # wine
    # wine-wayland
    # winePackages.full

    slurp # screenshotting
    grim # screenshotting

    termusic # nice music player
    spotify

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
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    ssh = {
      startAgent = false;
    };
  };

  services.tailscale.enable = true;
}
