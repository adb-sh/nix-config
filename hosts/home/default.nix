{ config, pkgs, lib, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
      ../../modules/base.nix
      ../../modules/zsh.nix
      ../../modules/home-assistant.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = lib.mkForce [ "vfat" "ext4" ];
    loader = {
      raspberryPi.version = 4;
      generic-extlinux-compatible.enable = lib.mkDefault true;
      grub.enable = lib.mkDefault false;
    };
    kernel.sysctl = {
      "net.ipv4.conf.all.forwarding" = true;
    };
  };

  networking = {
    useDHCP = lib.mkDefault true;
    # defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  networking.hostName = "home";

  #  Set your time zone.
  time.timeZone = "UTC";

  # Define a user account. Don't forget to set a password with ‘passwyd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.adb = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [ ];
  };
  users.users.root = {
    openssh.authorizedKeys.keyFiles = [
      ../../keys/ssh/adb
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
    };
  };

  networking.firewall.enable = false;

  system.stateVersion = "24.05";

  sdImage = lib.mkForce {
    compressImage = false;
    populateFirmwareCommands =
      let
        configTxt = pkgs.writeText "config.txt" ''
          [pi3]
          kernel=u-boot-rpi3.bin
          hdmi_force_hotplug=1

          [pi02]
          kernel=u-boot-rpi3.bin

          [pi4]
          kernel=u-boot-rpi4.bin
          enable_gic=1
          armstub=armstub8-gic.bin

          # Otherwise the resolution will be weird in most cases, compared to
          # what the pi3 firmware does by default.
          disable_overscan=1

          # Supported in newer board revisions
          arm_boost=1

          [cm4]
          # Enable host mode on the 2711 built-in XHCI USB controller.
          # This line should be removed if the legacy DWC2 controller is required
          # (e.g. for USB device mode) or if USB support is not required.
          otg_mode=1

          [all]
          # Boot in 64-bit mode.
          arm_64bit=1

          # U-Boot needs this to work, regardless of whether UART is actually used or not.
          # Look in arch/arm/mach-bcm283x/Kconfig in the U-Boot tree to see if this is still
          # a requirement in the future.
          enable_uart=1

          # Prevent the firmware from smashing the framebuffer setup done by the mainline kernel
          # when attempting to show low-voltage or overtemperature warnings.
          avoid_warnings=1
        '';
      in
      ''
        (cd ${pkgs.raspberrypifw}/share/raspberrypi/boot && cp bootcode.bin fixup*.dat start*.elf $NIX_BUILD_TOP/firmware/)

        # Add the config
        cp ${configTxt} firmware/config.txt

        # Add pi3 specific files
        cp ${pkgs.ubootRaspberryPi3_64bit}/u-boot.bin firmware/u-boot-rpi3.bin

        # Add pi4 specific files
        cp ${pkgs.ubootRaspberryPi4_64bit}/u-boot.bin firmware/u-boot-rpi4.bin
        cp ${pkgs.raspberrypi-armstubs}/armstub8-gic.bin firmware/armstub8-gic.bin
        cp ${pkgs.raspberrypifw}/share/raspberrypi/boot/bcm2711-rpi-4-b.dtb firmware/
        cp ${pkgs.raspberrypifw}/share/raspberrypi/boot/bcm2711-rpi-400.dtb firmware/
        cp ${pkgs.raspberrypifw}/share/raspberrypi/boot/bcm2711-rpi-cm4.dtb firmware/
        cp ${pkgs.raspberrypifw}/share/raspberrypi/boot/bcm2711-rpi-cm4s.dtb firmware/
      '';
    populateRootCommands = ''
      mkdir -p ./files/boot
      ${config.boot.loader.generic-extlinux-compatible.populateCmd} -c ${config.system.build.toplevel} -d ./files/boot
    '';
  };
}
