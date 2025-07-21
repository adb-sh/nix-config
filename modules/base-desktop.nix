{ config, pkgs, lib, options, ... }:
{
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
    firefox
    signal-desktop
    element-desktop
    libreoffice
    scribus
    kitty
    gnome.nautilus
    gparted
    maim
    xclip
    gimp
    inkscape
    gnome.gnome-disk-utility
    gnome.geary
    evince
    termusic # nice music player
    spotify
    # parsec-bin
    slurp # screenshotting
    grim # screenshotting
    loupe
    pamixer
    playerctl

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
    wev

    # gnome-keysign
    gnome.seahorse
  ];

  programs.direnv.enable = true;

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
}

