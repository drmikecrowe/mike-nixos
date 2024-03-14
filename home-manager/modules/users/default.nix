{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options = {
    host.home.users = {
      enabled = mkOption {
        default = [];
        type = with types; array;
        description = "Define which enabled users should be in polkit";
      };
    };
  };
}
