{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  graphics = config.host.feature.graphics;
  wayland =
    if (graphics.backend == "wayland")
    then true
    else false;
in {
  config = mkIf (graphics.enable && graphics.displayManager.manager == "sddm") {
    services = {
      displayManager = {
        sddm = {
          enable = mkDefault true;
          wayland.enable = mkDefault wayland;
        };
      };
    };
  };
}
