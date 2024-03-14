{lib, ...}:
with lib; {
  imports = [
    ./lvm.nix
    ./swap.nix
    ./tmp.nix
  ];
}
