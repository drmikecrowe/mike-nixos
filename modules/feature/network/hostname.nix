{
  config,
  lib,
  pkgs,
  ...
}: let
  defaultHostname =
    if (config.host.network.hostname == "null")
    then true
    else false;
in
  with lib; {
    options = {
      host.network.hostname = mkOption {
        type = with types; str;
        default = "null";
        description = "Hostname of system";
      };
      host.network.hostId = mkOption {
        type = with types; str;
        default = "null";
        description = "Hostname of system";
      };
    };

    config = {
      assertions = [
        {
          assertion = !defaultHostname;
          message = "[host.network.hostname] Enter a hostname to add network uniqueness";
        }
      ];

      networking = {
        search = ["local"];
        hostName = config.host.network.hostname;
        hostId = config.host.network.hostId;
      };
    };
  }
