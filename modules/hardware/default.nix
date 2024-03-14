{lib, ...}:
with lib; {
  imports = [
    ./bluetooth.nix
    ./cpu
    ./gpu
    ./monitors.nix
    ./printing.nix
    ./sound.nix
    ./yubikey.nix
  ];
}
