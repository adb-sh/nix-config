{ pkgs, config, lib, ... }: {
  environment.systemPackages = with pkgs; [
    # terraform
    # pulumi
    # pulumiPackages.pulumi-language-nodejs
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
    qlcplus
    age
    kustomize
    kustomize-sops
    kubeseal
    k9s
    dive
    virt-manager
    vagrant
    libarchive
    imagemagick
    kind
    kubelogin-oidc
    go
    stu
    gnumake
    jq
  ];
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };
}
