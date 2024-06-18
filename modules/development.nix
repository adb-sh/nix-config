{ pkgs, config, lib, ... }: {
  environment.systemPackages = with pkgs; [
    terraform
    pulumi
    pulumiPackages.pulumi-language-nodejs
    nodejs_20
    doctl
    kubectl
    kn
    func
    kubernetes-helm
    talosctl
    hey
    azure-cli
    buildpack
    deno
    kicad
    nodePackages.pnpm
    nodePackages.prisma
    python3
    python311Packages.pip
    freecad
    colmena
  ];
}
