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
  config = mkIf (displayServer == "x" && config.host.home.feature.gui.enable) {
    programs = {
      bash = {
        sessionVariables = {
          # XINITRC = "$XDG_CONFIG_HOME/X11/xinitrc";
        };
      };
    };
  };
}
