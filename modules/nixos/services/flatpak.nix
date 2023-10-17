{ config
, pkgs
, lib
, user
, ...
}: {
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

    home-manager.users.${user} = {
      xdg = {
        systemDirs.data = [
          "/var/lib/flatpak/exports/share"
          "/home/${user}/.local/share/flatpak/exports/share"
        ];
      };
    };
  };
}
