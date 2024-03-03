{dotfiles, ...}: {
  imports = [
    ./aliases.nix
    ./fzf.nix
    ./git.nix
    ./github.nix
    ./neovim.nix
    ./nixpkgs.nix
    ./scripts.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
  ];
}
