{ config, pkgs, lib, ... }: {

  config = {

    xdg = {
      portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
        #xdgOpenUsePortal = true;
      };
    };

    home-manager.users.${config.user} = {
      xdg = {
        systemDirs.data = [
          "/var/lib/flatpak/exports/share"
          "/home/mcrowe/.local/share/flatpak/exports/share"
        ];

        configFile."mimeapps.list".force = true;
        mimeApps = {
          enable = true;
          defaultApplications = {
            "x-scheme-handler/http" = [ "brave.desktop;" ];
            "application/xhtml+xml" = [ "brave.desktop;" ];
            "text/html" = [ "brave.desktop;" ];
            "x-scheme-handler/https" = [ "brave.desktop;" ];
            "image/gif" = [ "brave.desktop;" ];
            "image/png" = [ "brave.desktop;" ];
            "image/webp" = [ "brave.desktop;" ];
          };
          associations.added = {
            "x-scheme-handler/mailto" = "Mailspring.desktop";
            # others...
          };
        };

      };
    };
  };

}
