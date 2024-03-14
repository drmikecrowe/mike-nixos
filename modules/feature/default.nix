{lib, ...}:
with lib; {
  imports = [
    ./boot
    ./graphics
    ./powermanagement
    ./network
    ./virtualization
    ./home_manager.nix
    ./fonts.nix
  ];
}
