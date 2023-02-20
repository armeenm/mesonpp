{
  description = "";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs;
    nixpkgs-staging.url = github:nixos/nixpkgs/8c32008a028597514307f5685245ba8141d59048;
    utils.url = github:numtide/flake-utils;
  };

  outputs = inputs@{ self, utils, ... }: utils.lib.eachDefaultSystem (system:
    let
      sets = with inputs; {
        nixpkgs = import nixpkgs { inherit system; };
        nixpkgs-staging = import nixpkgs-staging { inherit system; };
      };

      pkgs = sets.nixpkgs;

      meson = with sets.nixpkgs-staging; callPackage ./meson {
        inherit (darwin.apple_sdk.frameworks) Foundation OpenGL AppKit Cocoa;
      };

      inherit (pkgs) lib stdenv mkShell;

    in {
      devShells.default = mkShell {
        hardeningDisable = [ "format" ];
        packages = [ meson ] ++ (with pkgs; [
          ninja
          python3
        ]);
      };
    }
  );
}
