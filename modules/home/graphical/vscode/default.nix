{ config
, lib
, pkgs
, dotfiles
, ...
}:
let
  ext = import ./ext.nix;
  keys = import ./keybindings.nix;
in
{
  programs.vscode = {
    enable = true;
    keybindings = keys;
  };
}
