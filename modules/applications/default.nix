{dotfiles, ...}: {
  imports = [
    ./_1password.nix
    ./appimage-run.nix
    ./duplicati.nix
    ./python.nix
    ./vivaldi.nix
  ];
}
