{ lib
, pkgs
, user
, ...
}:
let
  mkOption = value: lib.mkEnableOption { default = value; };
in
{
  options = {
    custom = {
      _1password = mkOption false;
      budgie = mkOption false;
      gui = mkOption false;
      kde = mkOption false;
      continue = mkOption false;
      duplicati = mkOption false;
      discord = mkOption false;
      flatpak = mkOption false;
      gnome = mkOption false;
      kitty = mkOption false;
      obsidian = mkOption false;
      slack = mkOption false;
      vivaldi = mkOption false;

      theme = {
        colors = lib.mkOption {
          type = lib.types.attrs;
          default = (import ../../colorscheme/gruvbox).light;
        };
        dark = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
      };
      secrets = lib.mkOption {
        type = lib.types.attrs;
        default = { };
      };
    };
  };
}
