{
  description = "Python pip flake";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.mach-nix.url = "github:DavHau/mach-nix/3.5.0";

  outputs = { nixpkgs, flake-utils, mach-nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        machNix = mach-nix.lib."${system}";
        devEnvironment = machNix.mkPython {
          requirements = builtins.readFile ./requirements.txt;
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            devEnvironment
            # pkgs.poetry
          ];
        };
      });
}
