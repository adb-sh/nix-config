{ pkgs, config, lib, ... }: {
  environment.systemPackages = with pkgs; [
    terraform
    pulumi
    pulumiPackages.pulumi-language-nodejs
    nodejs_20
    doctl
    kubectl
    kn
    kubernetes-helm
    talosctl
    azure-cli
    buildpack
    deno
    kicad
    nodePackages.pnpm
    nodePackages.prisma
  ];
}
