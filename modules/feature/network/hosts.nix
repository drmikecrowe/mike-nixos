{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.host.network.mask_ad_hosts;
in
  with lib; {
    options = {
      host.network.mask_ad_hosts = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enable blocking of most common ad servers";
        };
      };
    };

    # Network
    config = {
      networking = mkIf cfg.enable {
        extraHosts = builtins.readFile "${inputs.hosts}/hosts";
      };
    };
  }
