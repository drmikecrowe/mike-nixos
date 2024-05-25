{lib, ...}:
with lib; {
  imports = [
    ./boot
    ./graphics
    ./network
    ./virtualization
    ./home_manager.nix
    ./fonts.nix
  ];
}
