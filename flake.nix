{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = (import (inputs.nixpkgs) { inherit system; });
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
          ];
          packages = with pkgs; [
            beam.packages.erlang_27.elixir_1_18
            (beam.packages.erlang_27.elixir-ls.override {
              elixir = beam.packages.erlang_27.elixir_1_18;
            })
            caddy
            (writeShellScriptBin "file-server" ''
              caddy file-server --listen :8000 --root ./output
            '')
          ];
        };

        formatter = pkgs.nixpkgs-fmt;
      }
    );
}
