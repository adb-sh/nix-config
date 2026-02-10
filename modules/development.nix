{ pkgs, config, lib, ... }: {
  environment.systemPackages = with pkgs; [
    # terraform
    # pulumi
    # pulumiPackages.pulumi-language-nodejs
    # nodejs_20
    doctl
    kubectl
    kn
    func
    kubernetes-helm
    talosctl
    hey
    buildpack
    deno
    kicad
    nodePackages.pnpm
    nodePackages.prisma
    python3
    python311Packages.pip
    # freecad
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
    cue
    krew
    # timoni
    # kcl
    # kcl-language-server
    # gleam
    # erlang
    # elixir
    # opentofu
    vimPlugins.LazyVim
    s3cmd
    zed-editor
    yq
    traceroute
    unixtools.net-tools
  ];
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      # ovmf = {
      #   enable = true;
      #   packages = [
      #     (pkgs.OVMF.override {
      #       secureBoot = true;
      #       tpmSupport = true;
      #     }).fd
      #   ];
      # };
    };
  };

  services.ollama = {
    enable = true;
    loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b" "codellama"];
  };
}
