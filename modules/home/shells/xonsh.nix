{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  home.packages = with pkgs; [
    xonsh
  ];
}
