{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.feature.graphics.desktopManager;
in
  with lib; {
    imports = [
      # ./awesome.nix
      # ./budgie.nix
      ./gnome.nix
      # ./kde.nix
    ];
  }
