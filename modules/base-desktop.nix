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

  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts._0xproto
      nerd-fonts.droid-sans-mono
      ubuntu_font_family
      dejavu_fonts
      font-awesome
    ];
    fontconfig = {
      defaultFonts = {
        serif = [  "Ubuntu" "Vazirmatn" ];
        sansSerif = [ "monospace" "Vazirmatn" ];
        monospace = [ "fira-code" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    firefox
    signal-desktop
    element-desktop
    libreoffice
    scribus
    kitty
    nautilus
    gparted
    maim
    xclip
    gimp
    inkscape
    gnome-disk-utility
    geary
    evince
    termusic # nice music player
    spotify
    # parsec-bin
    slurp # screenshotting
    grim # screenshotting
    loupe
    pamixer
    playerctl
    ffmpeg-full
    vlc
    audacity

    # different common fonts for icons 
    # dejavu_fonts
    # font-awesome
    # font-awesome_5
    # unicode-emoji

    # audio foo
    pulsemixer
    blueberry

    # development
    vscode
    gcc
    wev

    # gnome-keysign
    seahorse
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

