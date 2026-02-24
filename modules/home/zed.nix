{ pkgs, lib, ... }:
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.master.zed-editor;

    extensions = [
      "nix"
      "toml"
      "gleam"
      "kotlin"
      "make"
      "elixir"
      "dockerfile"
      "helm"
    ];

    # settings.json rendered by HM
    userSettings = {
      base_keymap = "JetBrains";
      load_direnv = "shell_hook";
      buffer_font_family = "FiraCode Nerd Font";
      buffer_font_size = 14;
      ui_font_family = "Inter";
      ui_font_size = 16;
      terminal = {
        font_family = "FiraCode Nerd Font";
        font_size = 14;
      };
      session = {
        restore_unsaved_buffers = true;
        trust_all_worktrees = true;
      };
      title_bar = {
        show_sign_in = false;
      };
      git_panel = {
        dock = "right";
        default_width = 400;
      };

      # tell Zed which LSP to use for Kotlin
      languages = {
        Kotlin = {
          language_servers = [ "kotlin-lsp" ];
        };
      };

      # point Zed at the correct LSP binary
      lsp = {
        rust-analyzer = {
          initialization_options = {
            diagnostics = {
              enable = true;
            };
          };
          binary = {
            path = lib.getExe pkgs.rust-analyzer;
          };
        };
        kotlin-lsp = {
          binary = {
            path = lib.getExe pkgs.kotlin-language-server;
            env = {
              JAVA_HOME = "${pkgs.jdk17}";
            };
          };
          settings = {
            # https://github.com/fwcd/kotlin-language-server/blob/main/server/src/main/kotlin/org/javacs/kt/Configuration.kt
            formatting.ktfmt = {
              indent = 4;
              continuationIndent = 4;
            };
          };
        };
        elixir-ls.binary.path = lib.getExe pkgs.elixir-ls;
        nil.binary.path = lib.getExe pkgs.nil;
        nixd.binary.path = lib.getExe pkgs.nixd;
        package-version-server.binary.path = lib.getExe pkgs.package-version-server;
      };

      agent = {
        default_model = {
          provider = "ollama";
          model = "gpt-oss:20b";
        };
      };
    };
  };
}
