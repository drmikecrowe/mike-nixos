{ config
, inputs
, lib
, ...
}: {
  config = {
    # DNS service discovery
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      domainName = "local";
      publish = {
        enable = true;
        addresses = true;
        domain = true;
        workstation = true;
      };
    };

    # Network
    networking = {
      useDHCP = lib.mkDefault true;
      extraHosts = builtins.readFile "${inputs.hosts}/hosts";
      hosts = {
        "192.168.1.107" = [
          "sonarr.local"
          "radarr.local"
          "transfer.local"
          "sabnzbd.local"
          "crowenas.local"
          "jackett.local"
        ];
      };
    };
  };
}
