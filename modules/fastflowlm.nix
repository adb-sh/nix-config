{ pkgs, ... }:
let
  # buildXRT = pkgs.stdenv.mkDerivation {
  #   pname = "xrt";
  #   version = "2026-02-27";

  #   src = pkgs.fetchFromGitLab {
  #     owner = "superm1";
  #     repo = "xrt";
  #     domain = "gitlab.archlinux.org";
  #     rev = "main";
  #     sha256 = "0000000000000000000000000000000000000000000000000000"; # replace with actual
  #   };

  #   nativeBuildInputs = [
  #     pkgs.cmake
  #     pkgs.gcc
  #     pkgs.pkg-config
  #     pkgs.libtool
  #     pkgs.automake
  #     pkgs.autoconf
  #     # pkgs.make
  #   ];

  #   buildPhase = ''
  #     mkdir -p build
  #     cd build
  #     cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$out
  #     make -j$(nproc)
  #   '';

  #   installPhase = ''
  #     cd build
  #     make install
  #   '';
  # };

  # buildPlugin = pkgs.stdenv.mkDerivation {
  #   pname = "xrt-plugin-amdxdna";
  #   version = "2026-02-27";

  #   src = pkgs.fetchFromGitLab {
  #     owner = "superm1";
  #     repo = "xrt-plugin-amdxdna";
  #     domain = "gitlab.archlinux.org";
  #     rev = "main";
  #     sha256 = "sha256-rDQG8htS8TxXInowxSp6mO+3zjg4iGhAVcMxVned7Q8="; # replace with actual
  #   };

  #   nativeBuildInputs = [
  #     pkgs.cmake
  #     pkgs.gcc
  #     pkgs.pkg-config
  #     pkgs.libtool
  #     pkgs.automake
  #     pkgs.autoconf
  #     # pkgs.makepkg
  #     pkgs.pacman
  #   ];

  #   unpackPhase = ''
  #     mkdir -p $out
  #     cp -r $src/* $out/
  #   '';

  #   buildPhase = ''
  #     cd $out
  #     makepkg -si --noconfirm
  #   '';

  #   installPhase = ''
  #     echo "Installed $name via PKGBUILD"
  #   '';

  #   # buildPhase = ''
  #   #   mkdir -p build
  #   #   cd build
  #   #   cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$out
  #   #   make -j$(nproc)
  #   # '';

  #   # installPhase = ''
  #   #   cd build
  #   #   make install
  #   # '';
  # };
  fastflowlm = pkgs.stdenv.mkDerivation {
    pname = "fastflowlm";
    version = "0.1";

    src = pkgs.fetchFromGitHub {
      owner = "FastFlowLM";
      repo = "FastFlowLM";
      rev = "v0.9.34";
      sha256 = "sha256-1pzJks0FrpThgaas0jAP0S9CteNpt1/3ymPVwjPJSNc=";
    };

    nativeBuildInputs = [
      pkgs.cmake
      pkgs.gcc
    ];

    unpackPhase = ''
      mkdir -p $out
      cp -r $src/src/* $out/
    '';

    buildPhase = ''
      cd $out
      # cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$out
      cmake --preset linux-default
      cmake --build .
    '';

    installPhase = ''
      cd build
      cmake --install .
    '';

    meta = with pkgs.lib; {
      description = "FastFlowLM";
      license = licenses.mit;
    };
  };
in
{
  environment.systemPackages = [
    # buildXRT
    # buildPlugin
    fastflowlm
  ];
}
