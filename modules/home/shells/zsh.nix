{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
    };
  };
}
