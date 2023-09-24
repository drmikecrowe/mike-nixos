{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.physical {
    # DNS service discovery
    services.avahi = {
      enable = true;
      nssmdns = true;
      domainName = "local";
      publish = {
        enable = true;
        addresses = true;
        domain = true;
        workstation = true;
      };
    };

    networking.useDHCP = lib.mkDefault true;
  };
}
