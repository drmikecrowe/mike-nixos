{ config
, pkgs
, lib
, ...
}: {
  config = lib.mkIf pkgs.stdenv.isLinux {
    networking = {
      search = [ "local" ];
      networkmanager = { enable = true; };
    };
  };
}
