{
  config,
  user,
  lib,
  ...
}: {
  config = lib.mkIf config.custom.duplicati {
    # Duplicati backup
    services.duplicati = {
      inherit user;
      enable = true;
    };
  };
}
