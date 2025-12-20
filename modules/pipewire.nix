{ pkgs, config, lib, ... }: {
  # device network discovery
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;

  # sound.enable = true;
  services.pulseaudio = {
    enable = false;
    zeroconf.discovery.enable = true;
    extraClientConf = ''
      autospawn=yes
    '';
  };

  security.rtkit.enable = true; # so pipewire / pulseaudio can get higher priority

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };
}
