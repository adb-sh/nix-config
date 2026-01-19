{ pkgs, lib, ... }: {
  home.stateVersion = "23.05";
  programs = {
    k9s.enable = true;
    kitty.enable = true;
    obs-studio.enable = true;
    zed-editor.enable = true;
    freetube.enable = true;
    swaylock.enable = true;
  };
  # wayland.windowManager.sway.enable = true; # todo
  catppuccin = {
    enable = true;
    accent = "mauve";
    cursors.enable = true;
  };

  # programs.zed-editor = {
  #   enable = true;

  #   extensions = [
  #     "nix"
  #     "toml"
  #     "gleam"
  #     "kotlin"
  #   ];

  #   # settings.json rendered by HM
  #   userSettings = {
  #     # tell Zed which LSP to use for Kotlin
  #     languages = {
  #       "Kotlin" = {
  #         language_servers = [ "kotlin-language-server" ];
  #       };
  #     };

  #     # point Zed at the correct LSP binary
  #     lsp = {
  #       "kotlin-language-server" = {
  #         binary = {
  #           # if PATH detection is flaky on NixOS
  #           path = "${pkgs.kotlin-language-server}/bin/kotlin-language-server";
  #         };
  #         # optional: make sure Java sees the right JDK
  #         binary.env = {
  #           JAVA_HOME = "${pkgs.jdk17}";
  #         };
  #       };
  #     };
  #   };
  # };
}
