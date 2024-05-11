{
  config,
  lib,
  pkgs,
  ...
}: {
  xdg = {
    mimeApps = {
      enable = lib.mkDefault true;
    };
  };
}
