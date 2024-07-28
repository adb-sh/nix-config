# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./network.nix
      ./hardware-configuration.nix

      ../../modules/base.nix
      ../../modules/base-desktop.nix
      ../../modules/wayland.nix
      ../../modules/pipewire.nix
      ../../modules/bluetooth.nix
      ../../modules/zsh.nix
      ../../modules/development.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  networking.hostName = "naomi"; # Define your hostname.
  # Pick only one of the below networking options.
  #  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  #  Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  hardware.opengl = {
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
    extraPackages = [ pkgs.amdvlk ];
    driSupport = true;
    driSupport32Bit = true;
  };

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.adb = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
    "spotify"
    "steam"
    "steam-original"
    "steam-run"
    "parsec-bin"
    "terraform"
  ];

  environment.systemPackages = with pkgs; [
    pkgs.yubikey-personalization
    ungoogled-chromium
    gnome.gnome-control-center
    virt-manager
    speedtest-cli
    openrgb
    obs-studio
    obs-studio
  ];

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
