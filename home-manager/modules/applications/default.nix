{dotfiles, ...}: {
  imports = [
    ./atuin.nix
    ./aws-sso-cli.nix
    ./bash.nix
    ./bat.nix
    ./carapace.nix
    ./direnv.nix
    ./fish.nix
    ./github.nix
    ./git.nix
    ./gnupg.nix
    ./neovim.nix
    ./nixpkgs.nix
    ./starship.nix
    ./tmux.nix
    ./yazi.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
