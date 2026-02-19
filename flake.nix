{
  description = "my based nix configs :3";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix/v25.11";
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
      nixpkgs-unstable,
      nixpkgs-master,
      nixos-hardware,
      nixos-generators,
      catppuccin,
      home-manager,
      caelestia-shell,
    }:
    {
      nixosConfigurations =
        let
          desktop-modules = host: [
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = [
                (final: prev: {
                  inherit (caelestia-shell.packages.${prev.system}) caelestia-shell;
                  unstable = import nixpkgs-unstable { system = prev.system; };
                  master = import nixpkgs-master { system = prev.system; };
                })
              ];
              home-manager = {
                backupFileExtension = "backup";
                useGlobalPkgs = true;
                useUserPackages = true;
                users.adb = {
                  imports = [
                    catppuccin.homeModules.catppuccin
                    caelestia-shell.homeManagerModules.default
                    ./hosts/${host}/home.nix
                  ];
                };
              };
            }
          ];
        in
        {
          naomi = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./hosts/naomi
            ]
            ++ desktop-modules "naomi";
          };

          aven = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./hosts/aven
              nixos-hardware.nixosModules.framework-amd-ai-300-series
            ]
            ++ desktop-modules "aven";
          };

          home = nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            modules = [
              ./hosts/home
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
