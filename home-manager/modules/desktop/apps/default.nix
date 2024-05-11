{dotfiles, ...}: {
  imports = [
    ./kitty.nix
    ./vscode
    ./wezterm.nix
  ];
}
