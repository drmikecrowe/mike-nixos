{ config, pkgs, lib, ... }: {

  config.environment.systemPackages = with pkgs; [ vscode ];

  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  #   extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  #   #xdgOpenUsePortal = true;
  # };

  config = {

    home-manager.users.${config.user} = {
      xdg.systemDirs.data = [
        "/var/lib/flatpak/exports/share"
        "/home/mcrowe/.local/share/flatpak/exports/share"
      ];
    };
  };

}
