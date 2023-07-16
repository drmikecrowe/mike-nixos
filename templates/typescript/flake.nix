{
  description = "Typescript project";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs = { nixpkgs, mach-nix }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f:
        nixpkgs.lib.genAttrs supportedSystems
          (system: f system (import nixpkgs { inherit system; }));
    in
    rec {
      devShell = forAllSystems (system: pkgs:
        pkgs.mkShell {
          buildInputs = [
            # pkgs.nodejs
            # You can set the major version of Node.js to a specific one instead
            # of the default version
            pkgs.nodejs-18_x

            # You can choose pnpm, yarn, or none (npm).
            pkgs.nodePackages.pnpm
            # pkgs.yarn

            pkgs.nodePackages.typescript
            pkgs.nodePackages.typescript-language-server
          ];
        });
    };
}
