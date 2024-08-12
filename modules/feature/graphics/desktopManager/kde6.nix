{
  config,
  pkgs,
  lib,
  ...
}: let
  graphics = config.host.feature.graphics;
in {
  config = lib.mkIf (graphics.enable && graphics.desktopManager == "kde6") {
    services = {
      xserver.enable = true;
      desktopManager = {
        plasma6 = {enable = true;};
      };
    };
    environment.systemPackages = with pkgs; [
      kdePackages.qt5compat
      kdePackages.polkit-kde-agent-1
    ];
  };
}
