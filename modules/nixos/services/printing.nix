{ config
, pkgs
, ...
}: {
  config = {
    services.printing = {
      enable = true;
      # drivers = [ pkgs.gutenprint ];
      drivers = [ pkgs.samsung-unified-linux-driver ];
      browsing = true;
    };
  };
}
