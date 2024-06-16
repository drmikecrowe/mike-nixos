{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.aws-sso-cli;
in
  with lib; {
    options = {
      host.home.applications.aws-sso-cli = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables aws-sso-cli";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [aws-sso-cli];
      programs = {
        bash.initExtra = ''
          __aws_sso_profile_complete() {
              COMPREPLY=()
              local _args=''${AWS_SSO_HELPER_ARGS:- -L error --no-config-check}
              local cur
              _get_comp_words_by_ref -n : cur

              COMPREPLY=($(compgen -W '$(${pkgs.aws-sso-cli}/bin/.aws-sso-wrapped $_args list --csv -P "Profile=$cur" Profile)' -- ""))

              __ltrim_colon_completions "$cur"
          }

          aws-sso-profile() {
              local _args=''${AWS_SSO_HELPER_ARGS:- -L error --no-config-check}
              if [ -n "$AWS_PROFILE" ]; then
                  echo "Unable to assume a role while AWS_PROFILE is set"
                  return 1
              fi
              eval $(${pkgs.aws-sso-cli}/bin/.aws-sso-wrapped $_args eval -p "$1")
              if [ "$AWS_SSO_PROFILE" != "$1" ]; then
                  return 1
              fi
          }

          aws-sso-clear() {
              local _args=''${AWS_SSO_HELPER_ARGS:- -L error --no-config-check}
              if [ -z "$AWS_SSO_PROFILE" ]; then
                  echo "AWS_SSO_PROFILE is not set"
                  return 1
              fi
              eval $(aws-sso eval $_args -c)
          }

          complete -F __aws_sso_profile_complete aws-sso-profile
          complete -C ${pkgs.aws-sso-cli}/bin/.aws-sso-wrapped aws-sso
        '';

        fish.interactiveShellInit = ''
          function __complete_aws-sso
              set -lx COMP_LINE (commandline -cp)
              test -z (commandline -ct)
              and set COMP_LINE "$COMP_LINE "
              ${pkgs.aws-sso-cli}/bin/.aws-sso-wrapped
          end
          complete -f -c aws-sso -a "(__complete_aws-sso)"

          function aws-sso-profile
            set --local _args (string split -- ' ' $AWS_SSO_HELPER_ARGS)
            set -q AWS_SSO_HELPER_ARGS; or set --local _args -L error --no-config-check
            if [ -n "$AWS_PROFILE" ]
                echo "Unable to assume a role while AWS_PROFILE is set"
                return 1
            end
            eval $(${pkgs.aws-sso-cli}/bin/.aws-sso-wrapped $_args eval -p $argv[1])
            if [ "$AWS_SSO_PROFILE" != "$1" ]
                return 1
            end
          end

          function __aws_sso_profile_complete
            set --local _args (string split -- ' ' $AWS_SSO_HELPER_ARGS)
            set -q AWS_SSO_HELPER_ARGS; or set --local _args -L error --no-config-check
            set -l cur (commandline -t)

            set -l cmd "${pkgs.aws-sso-cli}/bin/.aws-sso-wrapped list $_args --csv -P Profile=$cur Profile"
            for completion in (eval $cmd)
              printf "%s\n" $completion
            end
          end
          complete -f -c aws-sso-profile -f -a '(__aws_sso_profile_complete)'

          function aws-sso-clear
            set --local _args (string split -- ' ' $AWS_SSO_HELPER_ARGS)
            set -q AWS_SSO_HELPER_ARGS; or set --local _args -L error
            if [ -z "$AWS_SSO_PROFILE" ]
                echo "AWS_SSO_PROFILE is not set"
                return 1
            end
            eval "$(${pkgs.aws-sso-cli}/bin/.aws-sso-wrapped $_args eval -c | string replace "unset" "set --erase" )"
          end
        '';
      };
    };
  }
