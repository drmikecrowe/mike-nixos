# Custom packages, that can be defined similarly to ones from nixpkgs
# Build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{pkgs}: {
  argc-completions = pkgs.callPackage ./argc-completions.nix {};
  # sst = pkgs.callPackage ./sst.nix {};
  xonsh = pkgs.callPackage ./xonsh.nix {};
}
