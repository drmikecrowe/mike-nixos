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
          #   QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.kdePackages.qtbase.outPath}/lib/qt-6/plugins";
          # XINITRC = "$XDG_CONFIG_HOME/X11/xinitrc";
        };
      };
    };
  };
}
