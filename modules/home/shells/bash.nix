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
      historyControl = ["ignoredups" "ignorespace"];
    };
  };
}
