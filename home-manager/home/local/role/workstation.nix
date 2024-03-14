{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  imports = [
  ];

  xdg = {
    mimeApps = {
      enable = mkDefault true;
    };
  };
}
