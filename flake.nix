{
  description = "my based nix configs :3";
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-25.11;
    sops.url = github:mic92/sops-nix;
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
  };
  outputs =
    { self
    , nixpkgs
    , sops
    , nixos-hardware
    , nixos-generators
    , catppuccin
    , home-manager
    }: {
      nixosConfigurations = {

        naomi = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/naomi
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.users.adb = {
                imports = [
                  catppuccin.homeModules.catppuccin
                  ./hosts/naomi/home.nix
                ];
              };
            }
          ];
        };

        home = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./hosts/home
            nixos-hardware.nixosModules.raspberry-pi-4 # add hardware options for rpi4 f/e spi
            ./modules/spi.nix
          ];
        };
      };

      images = builtins.mapAttrs
        (name: host: (nixos-generators.nixosGenerate
          {
            modules = host._module.args.modules;
            system = "aarch64-linux";
            format = "sd-aarch64";
            pkgs = nixpkgs.legacyPackages.aarch64-linux;
          }))
        self.nixosConfigurations;

      colmena = {
        meta.allowApplyAll = false;
        defaults = { name, config, ... }: {
          deployment = {
            # tags = [ ];
            targetHost = config.networking.fqdn;
            targetUser = "root";
          };
        };
      } // builtins.mapAttrs
        (name: host: {
          nixpkgs = { inherit (host.config.nixpkgs) system; };
          imports = host._module.args.modules;
        })
        self.nixosConfigurations;
    };
}
