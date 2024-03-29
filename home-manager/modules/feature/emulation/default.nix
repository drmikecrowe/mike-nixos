{lib, ...}:
with lib; {
  imports = [
    ./flatpak.nix
    ./windows.nix
  ];
}
