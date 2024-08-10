# Custom packages, that can be defined similarly to ones from nixpkgs
# Build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{
  inputs,
  pkgs,
}: {
  # inherit (inputs.nixpkgs-SamLukeYes.legacyPackages.x86_64-linux) xonsh;
  # add more packages here
  # xonsh = pkgs.callPackage ./xonsh {};
}
