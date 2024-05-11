{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg10 = config.host.application.python310Full;
  cfg11 = config.host.application.python311Full;
  cfg12 = config.host.application.python312Full;
in
  with lib; {
    options = {
      host.application = {
        python310Full = {
          enable = mkOption {
            default = false;
            type = with types; bool;
            description = "Enables python310Full";
          };
        };
        python311Full = {
          enable = mkOption {
            default = false;
            type = with types; bool;
            description = "Enables python311Full";
          };
        };
        python312Full = {
          enable = mkOption {
            default = false;
            type = with types; bool;
            description = "Enables python312Full";
          };
        };
      };
    };

    config = mkMerge [
      (mkIf cfg10.enable {
        environment.systemPackages = with pkgs; [
          python310Full
          python310Packages.flake8
          python310Packages.mypy
          python310Packages.pip
          python310Packages.pipx
          python310Packages.poetry-core
          python310Packages.pynvim
          # python310Packages.tomli
        ];
      })
      (mkIf cfg11.enable {
        environment.systemPackages = with pkgs; [
          python311Full
          python311Packages.flake8
          python311Packages.mypy
          python311Packages.pip
          python311Packages.pipx
          python311Packages.poetry-core
          python311Packages.pynvim
          python311Packages.tomli
        ];
      })
      (mkIf cfg12.enable {
        environment.systemPackages = with pkgs; [
          python312Full
          python312Packages.flake8
          python312Packages.mypy
          python312Packages.pip
          python312Packages.pipx
          python312Packages.poetry-core
          python312Packages.pynvim
          python312Packages.tomli
        ];
      })
    ];
  }
