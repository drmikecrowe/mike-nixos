{
  config,
  dotfiles,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.tmux;
in
  with lib; {
    options = {
      host.home.applications.tmux = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables tmux";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        tmux
        (pkgs.writeShellApplication {
          name = "pux";
          runtimeInputs = [pkgs.tmux];
          text = ''
            PRJ="$(zoxide query -i)"
            echo "Launching tmux for $PRJ"
            set -x
            cd "$PRJ" && \
              exec tmux -S "$PRJ".tmux attach
          '';
        })
      ];

      programs.tmux = {
        enable = true;
        shortcut = "a";
        baseIndex = 1;
        newSession = true;
        # Stop tmux+escape craziness.
        escapeTime = 0;
        # Force tmux to use /tmp for sockets (WSL2 compat)
        secureSocket = false;

        plugins = with pkgs; [
          tmuxPlugins.yank
          tmuxPlugins.copycat
          tmuxPlugins.resurrect
          tmuxPlugins.pain-control
          tmuxPlugins.sensible
        ];

        extraConfig = builtins.readFile "${dotfiles}/tmux.conf";
      };
    };
  }
