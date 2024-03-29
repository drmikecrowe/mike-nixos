{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  cfg = config.host.home.feature.virtualization.flatpak;
in
  with lib; {
    options = {
      host.home.feature.virtualization.flatpak = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enable support for Flatpak containerization";
        };
      };
    };

    config = mkIf cfg.enable {
      xdg = {
        systemDirs.data = [
          "/var/lib/flatpak/exports/share"
          "/home/${username}/.local/share/flatpak/exports/share"
        ];
      };
    };
  }
