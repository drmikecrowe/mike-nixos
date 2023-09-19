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
            "x-scheme-handler/http" = [ "microsoft-edge.desktop;" ];
            "application/xhtml+xml" = [ "microsoft-edge.desktop;" ];
            "text/html" = [ "microsoft-edge.desktop;" ];
            "x-scheme-handler/https" = [ "microsoft-edge.desktop;" ];
            "image/gif" = [ "microsoft-edge.desktop;" ];
            "image/png" = [ "microsoft-edge.desktop;" ];
            "image/webp" = [ "microsoft-edge.desktop;" ];
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
