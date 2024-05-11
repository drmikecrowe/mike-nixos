{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    host = {
      home = {
        feature = {
          fonts = {
            enable = lib.mkDefault true;
          };
          mime.defaults = {
            enable = lib.mkDefault true;
          };
          theming = {
            enable = lib.mkDefault true;
          };
          ssh = {
            enable = lib.mkDefault true;
          };
          emulation = {
            windows.enable = lib.mkDefault true;
          };
          virtualization = {
            flatpak.enable = lib.mkForce true;
          };
          gui = {
            enable = lib.mkDefault true;
            displayServer = "x";
            desktopEnvironment = "gnome";
          };
        };
      };
    };
    home = {
      packages = with pkgs; [
        bcompare
        betterbird
        qcad
        dbeaver
      ];
    };
  };
}
