{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  imports = [
  ];

  host = {
    home = {
      applications = {
      };
      feature = {
        fonts.enable = mkDefault true;
        mime.defaults.enable = mkDefault true;
        theming.enable = mkDefault true;
      };
    };
  };
}
