{ config
, user
, lib
, ...
}: {
  config = lib.mkIf config.custom.duplicati.enable {
    # Duplicati backup
    services.duplicati = {
      inherit user;
      inherit (config.custom.duplicati) enable;
    };
  };
}
