{lib, ...}:
with lib; {
  imports = [
    ./emulation
    ./fonts.nix
    ./mime-defaults.nix
    ./ssh.nix
    ./theming.nix
  ];
}
