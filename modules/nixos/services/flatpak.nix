{ config, pkgs, lib, ... }: {

  options = {
    flatpak = {
      enable = lib.mkEnableOption {
        description = "Enable Budgie.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.flatpak.enable {
    services.flatpak.enable = false;

    home-manager.users.${config.user} = {
      xdg = {
        systemDirs.data = [
          "/var/lib/flatpak/exports/share"
          "/home/mcrowe/.local/share/flatpak/exports/share"
        ];
      };
    };
  };

}
