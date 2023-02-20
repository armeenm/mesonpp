{ pkgs }:

let
  inherit (pkgs) nixpkgs;
  inherit (nixpkgs) lib;

in nixpkgs.llvmPackages_14.stdenv.mkDerivation {
  pname = "template";
  version = "0.1.0";
  src = ./.;

  nativeBuildInputs = with nixpkgs; [
    meson
    ninja
    pkg-config
  ];

  buildInputs = with nixpkgs; [
    fmt_9
  ];

  hardeningEnable = [ "pie" ];
  #mesonBuildType = "release";
}
