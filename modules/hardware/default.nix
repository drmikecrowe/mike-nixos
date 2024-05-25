{lib, ...}:
with lib; {
  imports = [
    ./bluetooth.nix
    ./monitors.nix
    ./printing.nix
    ./sound.nix
    ./yubikey.nix
  ];
}
