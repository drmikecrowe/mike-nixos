{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application._1password;
in
  with lib; {
    options = {
      host.application._1password = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables _1password";
        };
      };
    };

    config = mkIf cfg.enable {
      programs = {
        _1password.enable = true;
        _1password-gui = {
          enable = true;
          polkitPolicyOwners = ["mcrowe"]; # TODO: how can we pass this in?
        };
      };

      environment.etc = {
        "1password/custom_allowed_browsers" = {
          text = ''
            vivaldi-bin
            wavebox
          '';
          mode = "0755";
        };
      };
    };
  }
