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
    extensions = with pkgs.vscode-extensions; pkgs.vscode-utils.extensionsFromVscodeMarketplace ext.extensions;
  };

  home.file.".config/Code/User/settings.json".source = "${dotfiles}/vscode/settings.json";
}
