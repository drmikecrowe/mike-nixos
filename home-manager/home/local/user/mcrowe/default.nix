{
  config,
  lib,
  pkgs,
  specialArgs,
  ...
}: {
  imports = [
    ./aliases.nix
    ./git.nix
    ./gtk.nix
    ./dconf.nix
    ./mcrowe.nix
    ./ssh.nix
  ];
}
