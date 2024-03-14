{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (specialArgs) kioskUsername kioskURL;
  displayServer = config.host.home.feature.gui.displayServer;
in {
  config = mkIf (displayServer == "wayland" && config.host.home.feature.gui.enable) {
    ## TODO This should be modularized as these are common settings for all wayland desktops or window managers

    home.packages = with pkgs; [
    ];

    # sessionVariables = {
    #   QT_QPA_PLATFORM = "wayland";
    #   SDL_VIDEODRIVER = "wayland";
    #   XDG_SESSION_TYPE = "wayland";
    # };
  };
}
