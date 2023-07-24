{
  description = "Marlowe Starter Kit";

  nixConfig = {
    extra-substituters = [
      "https://cache.zw3rk.com"
      "https://cache.iog.io"
      "https://hydra.iohk.io"
      "https://tweag-jupyter.cachix.org"
    ];
    extra-trusted-public-keys = [
      "loony-tools:pr9m4BkM/5/eSTZlkQyRt57Jz7OMBxNSUiMC4FkcNfk="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "tweag-jupyter.cachix.org-1:UtNH4Zs6hVUFpFBTLaA4ejYavPo5EFFqgd7G7FxGW9g="
    ];
  };

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    marlowe = {
      type = "github";
      owner = "input-output-hk";
      repo = "marlowe-cardano";
      ref = "121201ec9563a23b2b8a90c3544ebf15fe81c82f";  # OLDER COMMIT (succeeds)
    # ref = "bf4b8c31a9c696b0e29e9b269b3f2fc176537089";  # NEWER COMMIN (fails)
    };
  };

  outputs = { self, flake-compat, flake-utils, nixpkgs, marlowe }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        mp = marlowe.packages.${system};
      in rec {
        devShell = pkgs.mkShell {
          buildInputs = [
            mp.ghc8107.marlowe-cli-exe-marlowe-cli  # OLDER DERIVATION (succeeds)
          # mp.marlowe-cli-exe-marlowe-cli-ghc8107  # NEWER DERIVATION (fails)
          ];
        };
      }
    );
}
