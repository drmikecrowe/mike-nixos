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
      fileSystems = let
        mkRoSymBind = path: {
          device = path;
          fsType = "fuse.bindfs";
          options = ["ro" "resolve-symlinks" "x-gvfs-hide"];
        };
        aggregatedFonts = pkgs.buildEnv {
          name = "system-fonts";
          paths = config.fonts.fonts;
          pathsToLink = ["/share/fonts"];
        };
      in {
        # Create an FHS mount to support flatpak host icons/fonts
        #"/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
        "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
      };

      services.flatpak.enable = true;
      system.fsPackages = [pkgs.bindfs];
      xdg.portal.enable = true;

      # TODO: I needed this before, do i now?
      # home-manager.users.${user} = {
      #   xdg = {
      #     systemDirs.data = [
      #       "/var/lib/flatpak/exports/share"
      #       "/home/${user}/.local/share/flatpak/exports/share"
      #     ];
      #   };
      # };
    };
  }
