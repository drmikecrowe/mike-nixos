{ config
, pkgs
, lib
, ...
}: {
  config = lib.mkIf (config.physical && pkgs.stdenv.isLinux) {
    networking = {
      search = [ "local" ];
      networkmanager = { enable = true; };
    };
  };
}
