{ config
, pkgs
, lib
, user
, ...
}: {
  config = lib.mkIf config.custom.continue {
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
