{ config
, pkgs
, lib
, user
, ...
}: {
  config = lib.mkIf config.custom.flatpak {
    services.flatpak.enable = true;

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
