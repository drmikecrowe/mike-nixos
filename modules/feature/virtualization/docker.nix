{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.host.feature.virtualization.docker;

  docker_storage_driver = "overlay2";
in {
  options = {
    host.feature.virtualization.docker = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables tools and daemon for containerization";
      };
    };
  };

  config = mkIf (cfg.enable) {
    environment = {
      etc = {
        "docker/daemon.json" = {
          text = ''
            {
              "experimental": true,
              "live-restore": true,
              "shutdown-timeout": 120
            }
          '';
          mode = "0600";
        };
      };

      systemPackages = with pkgs; [docker-compose];
    };

    users.groups = {docker = {};};

    virtualisation = {
      docker = {
        enable = true;
        rootless = {
          enable = true;
          setSocketVariable = true;
          daemon = {
            settings = {
              dns = ["1.1.1.1"];
            };
          };
        };
        logDriver = "local";
        storageDriver = docker_storage_driver;
      };

      oci-containers.backend = mkDefault "docker";
    };
  };
}
