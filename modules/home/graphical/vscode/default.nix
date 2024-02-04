{
  config,
  lib,
  pkgs,
  dotfiles,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };
}
