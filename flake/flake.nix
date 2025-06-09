{
  description = "Пример Python-проекта с flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShell = pkgs.mkShell {
          name = "python-dev-shell";
          buildInputs = [ pkgs.python3 pkgs.python3Packages.pip ];
          shellHook = ''
            echo "Добро пожаловать в Python dev shell!"
          '';
        };
      });
}
