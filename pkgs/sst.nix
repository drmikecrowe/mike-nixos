{
  lib,
  makeWrapper,
  buildGoModule,
  fetchFromGitHub,
  pulumi-bin,
  nodejs_20,
  esbuild,
  system,
}: let
  # Fetch the specific version of nixpkgs
  specificPkgs =
    import (builtins.fetchTarball {
      # URL to the tarball of the specific nixpkgs commit
      # Choose the right version for bun using https://lazamar.co.uk/nix-versions/?channel=nixpkgs-unstable&package=bun
      url = "https://github.com/NixOS/nixpkgs/archive/e89cf1c932006531f454de7d652163a9a5c86668.tar.gz";
      sha256 = "sha256:09cbqscrvsd6p0q8rswwxy7pz1p1qbcc8cdkr6p6q8sx0la9r12c";
    }) {
      inherit system;
    };

  # Use bun from the specific nixpkgs version
  bun = specificPkgs.bun;
in
  buildGoModule rec {
    pname = "sst";
    version = "0.0.332";

    src = fetchFromGitHub {
      owner = "sst";
      repo = "ion";
      rev = "v${version}";
      hash = "sha256-+o3eZYBYK7tmoSITaGpMgXkQiu0snvr4G6eGw/Qk6FM=";
    };

    vendorHash = "sha256-PlG3K/PujT6JeUfPVQpiGIfVy/y5ZqbkIeTEC6YH7hQ=";

    buildInputs = [makeWrapper pulumi-bin bun nodejs_20 esbuild];

    ldflags = ["-s" "-w" "-X main.version=${version}"];

    preBuild = ''
      export PATH=$PATH:${bun}/bin:${nodejs_20}/bin:${esbuild}/bin
      npm i -g esbuild
      go build -o ./pkg/platform/dist/bridge/bootstrap ./pkg/platform/bridge
      bash -c 'cd ./pkg/platform && ./scripts/build-functions'
    '';

    postInstall = ''
      mkdir -p $out/bin
      set -x
      ls -1b ${pulumi-bin}/bin/ | while read f; do
        ln -s ${pulumi-bin}/bin/$f $out/bin/$f
      done
      ln -s ${bun}/bin/bun $out/bin/bun
    '';

    CGO_ENABLED = 0;

    meta = with lib; {
      homepage = "https://github.com/sst/ion";
      description = "Ion is a new engine for deploying SST apps. It uses Pulumi and Terraform, as opposed to CDK and CloudFormation..";
      mainProgram = "sst";
      maintainers = with maintainers; [averagebit];
      sourceProvenance = with sourceTypes; [fromSource];
      license = licenses.mit;
    };
  }
