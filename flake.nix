{
  description = "melos based nix configs";
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-23.05;
    sops.url = github:mic92/sops-nix;
  };
  outputs = { self, nixpkgs, sops, ... }: {
    nixosConfigurations = {

      naomi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/naomi/configuration.nix
          ./modules/base.nix
          ./modules/wayland.nix
          ./modules/pipewire.nix
          ./modules/bluetooth.nix
          ./modules/zsh.nix
        ];
      };
    };
  };
}


