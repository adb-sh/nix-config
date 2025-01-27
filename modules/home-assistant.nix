{ pkgs, config, lib, ... }: {

  services.home-assistant = {
    enable = true;
    extraComponents = [
      "esphome"
      "met"
      "radio_browser"
      "wled"
      "zha"
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
      scene = "!include scenes.yaml";
      script = "!include scripts.yaml";
      automation = "!include automations.yaml";
    };
  };
}
