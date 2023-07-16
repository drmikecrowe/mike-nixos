{
  description = "Typescript project";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs = { nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
    in
    {
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
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
          };
        });
    };
}
