{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  cfg = config.host.home.applications.fish;
in
  with lib; {
    options = {
      host.home.applications.fish = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables fish";
        };
      };
    };

    config = mkIf cfg.enable {
      # Packages used in abbreviations and aliases
      home.packages = with pkgs; [
        fishPlugins.colored-man-pages
        fishPlugins.grc
        fishPlugins.plugin-git
      ];

      home.sessionVariables.fish_greeting = "";

      programs = {
        fish = {
          enable = true;

          interactiveShellInit = ''
            fish_vi_key_bindings
            bind yy fish_clipboard_copy
            bind Y fish_clipboard_copy
            bind -M visual y fish_clipboard_copy
            bind -M default p fish_clipboard_paste
            set -g fish_vi_force_cursor
            set -g fish_cursor_default block
            set -g fish_cursor_insert line
            set -g fish_cursor_visual block
            set -g fish_cursor_replace_one underscore
            set -gx PNPM_HOME "/home/${username}/.local/share/pnpm"
            if not string match -q -- $PNPM_HOME $PATH
              set -gx PATH "$PNPM_HOME" $PATH
            end
            if not string match -q -- /home/${username}/bin $PATH
              set -gx PATH "/home/${username}/bin" $PATH
            end
          '';
        };
      };
    };
  }
