{ pkgs, ... }:
{
  services = {
    accounts-daemon.enable = true;
    printing.enable = true;
    illum.enable = true;
    yubikey-agent.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
    gnome.gnome-keyring.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts._0xproto
      nerd-fonts.droid-sans-mono
      ubuntu-classic
      dejavu_fonts
      font-awesome
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Ubuntu" ];
        sansSerif = [ "0xProto Nerd Font" ];
        monospace = [ "FiraCode Nerd Font" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    firefox
    signal-desktop
    element-desktop
    libreoffice
    # scribus
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
    # spotify
    # parsec-bin
    slurp # screenshotting
    grim # screenshotting
    loupe
    pamixer
    playerctl
    ffmpeg-full
    vlc
    audacity
    freetube
    tidal-hifi

    # different common fonts for icons
    # dejavu_fonts
    # font-awesome
    # font-awesome_5
    # unicode-emoji

    # audio foo
    pulsemixer
    blueberry

    # development
    # vscode
    gcc
    wev

    # gnome-keysign
    seahorse
    bitwarden-desktop
  ];

  programs.direnv.enable = true;

  environment.shellInit = ''
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
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
