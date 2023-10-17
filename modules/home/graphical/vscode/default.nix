{ config
, lib
, pkgs
, ...
}:
let
  ext = import ./ext.nix;
  settings = import ./settings.nix;
  keys = import ./keybindings.nix;
in
{
  programs.vscode = {
    enable = true;
    userSettings = settings;
    keybindings = keys;
    extensions = with pkgs.vscode-extensions;  pkgs.vscode-utils.extensionsFromVscodeMarketplace ext.extensions;
  };
}
