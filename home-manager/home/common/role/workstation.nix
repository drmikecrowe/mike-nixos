{
  config,
  lib,
  pkgs,
  ...
}: {
  host = {
    home = {
      applications = {
      };
      feature = {
        fonts.enable = lib.mkDefault true;
        mime.defaults.enable = lib.mkDefault true;
        theming.enable = lib.mkDefault true;
      };
    };
  };
}
