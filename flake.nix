{
  description = "my based nix configs :3";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix/v25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      nixos-generators,
      catppuccin,
      home-manager,
      caelestia-shell,
    }:
    {
      nixosConfigurations = {

        naomi = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/naomi
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = [
                (final: prev: {
                  inherit (caelestia-shell.packages.${prev.system}) caelestia-shell;
                })
              ];
            }
            {
              home-manager = {
                backupFileExtension = "backup";
                users.adb = {
                  imports = [
                    catppuccin.homeModules.catppuccin
                    caelestia-shell.homeManagerModules.default
                    ./hosts/naomi/home.nix
                  ];
                };
              };
            }
          ];
        };

        aven = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/aven
            nixos-hardware.nixosModules.framework-amd-ai-300-series
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = [
                (final: prev: {
                  inherit (caelestia-shell.packages.${prev.system}) caelestia-shell;
                })
              ];
            }
            {
              home-manager = {
                backupFileExtension = "backup";
                users.adb = {
                  imports = [
                    catppuccin.homeModules.catppuccin
                    caelestia-shell.homeManagerModules.default
                    ./hosts/aven/home.nix
                  ];
                };
              };
            }
          ];
        };

        home = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./hosts/home
            nixos-hardware.nixosModules.raspberry-pi-4
            ./modules/spi.nix
          ];
        };
        melo-home = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./hosts/melo-home
            nixos-hardware.nixosModules.raspberry-pi-4
            ./modules/spi.nix
          ];
        };
      };

      images = builtins.mapAttrs (
        name: host:
        (nixos-generators.nixosGenerate {
          modules = host._module.args.modules;
          system = "aarch64-linux";
          format = "sd-aarch64";
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
        })
      ) self.nixosConfigurations;

      colmena = {
        meta.allowApplyAll = false;
        defaults =
          { name, config, ... }:
          {
            deployment = {
              # tags = [ ];
              targetHost = config.networking.fqdn;
              targetUser = "root";
            };
          };
      }
      // builtins.mapAttrs (name: host: {
        nixpkgs = { inherit (host.config.nixpkgs) system; };
        imports = host._module.args.modules;
      }) self.nixosConfigurations;
    };
}
