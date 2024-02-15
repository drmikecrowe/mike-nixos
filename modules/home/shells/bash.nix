{
  config,
  pkgs,
  lib,
  user,
  ...
}: let
  defaultShell = "fish";
  defaultExec = "${pkgs.fish}/bin/fish";
in {
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      historyControl = ["ignoredups" "ignorespace"];
    };
  };
}
