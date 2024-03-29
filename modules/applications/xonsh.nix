{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.xonsh;
in
  with lib; {
    options = {
      host.application.xonsh = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables xonsh";
        };
      };
    };

    config = mkIf cfg.enable {
      programs.xonsh.package = pkgs.xonsh.override {
        extraPackages = ps: [
          (ps.buildPythonPackage rec {
            name = "xontrib-fish-completer";
            version = "0.0.1";

            src = pkgs.fetchFromGitHub {
              owner = "xonsh";
              repo = "${name}";
              rev = "${version}";
              sha256 = "sha256-PhhdZ3iLPDEIG9uDeR5ctJ9zz2+YORHBhbsiLrJckyA=";
            };

            meta = {
              homepage = "https://github.com/xonsh/xontrib-fish-completer";
              description = "Populate rich completions using fish and remove the default bash based completer";
              license = pkgs.lib.licenses.mit;
              maintainers = [];
            };

            prePatch = ''
              pkgs.lib.substituteInPlace pyproject.toml --replace '"xonsh>=0.12.5"' ""
            '';
            patchPhase = "sed -i -e 's/^dependencies.*$/dependencies = []/' pyproject.toml";
            doCheck = false;
          })
        ];
      };
    };
  }
