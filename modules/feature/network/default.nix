{lib, ...}:
with lib; {
  imports = [
    ./avahi.nix
    ./hosts.nix
    ./hostname.nix
    ./wired.nix
  ];
}
