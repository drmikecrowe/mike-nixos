{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  # Packages used in abbreviations and aliases
  home.packages = with pkgs; [
    curl
    eza
    grc
    fishPlugins.colored-man-pages
    fishPlugins.grc
    fishPlugins.plugin-git
  ];

  home.sessionVariables.fish_greeting = "";

  programs = {
    fzf.enableFishIntegration = true;
    starship.enableFishIntegration = true;
    zoxide.enableFishIntegration = true;

    fish = {
      enable = true;

      functions = {
        ping = {
          description = "Improved ping";
          argumentNames = "target";
          body = "${pkgs.prettyping}/bin/prettyping --nolegend $target";
        };
      };

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
        set -gx PNPM_HOME "/home/${user}/.local/share/pnpm"
        if not string match -q -- $PNPM_HOME $PATH
          set -gx PATH "$PNPM_HOME" $PATH
        end
        if not string match -q -- /home/${user}/bin $PATH
          set -gx PATH "/home/${user}/bin" $PATH
        end
      '';
      loginShellInit = "";

      shellInit = "";
    };
  };
}
