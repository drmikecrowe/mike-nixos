{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      historyControl = ["ignoredups" "ignorespace"];
    };
  };
}
