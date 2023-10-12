{ config
, pkgs
, lib
, user
, ...
}: {
  options = {
    continue = {
      enable = lib.mkEnableOption {
        description = "Enable Continue.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.continue.enable {
    systemd.user.services.continue-server = {
      description = "Continue Server Service";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        Type = "simple";
        WorkingDirectory = "/home/${user}/Programming/Personal/continue";
        Environment = "PATH=/home/${user}/.nix-profile/bin:/run/wrappers/bin:/run/current-system/sw/bin";
        ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.direnv}/bin/direnv exec . python3 -m continuedev.src.continuedev.server.main'";
        Restart = "always";
      };
    };
  };
}
