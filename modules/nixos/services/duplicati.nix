{ config
, user
, lib
, ...
}: {
  options = {
    duplicati = {
      enable = lib.mkEnableOption {
        description = "Enable duplicati.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.duplicati.enable {
    # Duplicati backup
    services.duplicati = {
      inherit user;
      enable = true;
    };
  };
}
