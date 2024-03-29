{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.feature.virtualization.flatpak;
in
  with lib; {
    options = {
      host.feature.virtualization.flatpak = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enable support for Flatpak containerization";
        };
      };
    };

    config = mkIf cfg.enable {
      services.flatpak = {
        enable = true;
        remotes = {
          "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
          "flathub-beta" = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
        };
        packages = [
        ];
      };
    };
  }
