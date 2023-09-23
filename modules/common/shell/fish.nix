{ config, pkgs, lib, ... }: {

  users.users.${config.user}.shell = pkgs.fish;
  programs.fish.enable =
    true; # Needed for LightDM to remember username (TODO: fix)

  home-manager.users.${config.user} = {

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

    programs.starship.enableFishIntegration = true;
    programs.zoxide.enableFishIntegration = true;
    programs.fzf.enableFishIntegration = true;

    programs.fish = {
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
        set -gx PNPM_HOME "/home/mcrowe/.local/share/pnpm"
        if not string match -q -- $PNPM_HOME $PATH
          set -gx PATH "$PNPM_HOME" $PATH
        end
        if not string match -q -- /home/mcrowe/bin $PATH
          set -gx PATH "/home/mcrowe/bin" $PATH
        end
      '';
      loginShellInit = "";

      shellInit = "";

    };

    xdg.desktopEntries = lib.mkIf config.gui.enable {
      "kitty-fish" = {
        name = "Fish (kitty)";
        genericName = "Terminal emulator";
        exec = "kitty fish -li";
        icon = "fish";
        categories = [ "System" "TerminalEmulator" "Utility" ];
        type = "Application";
        terminal = false;
      };
    };
  };

}
