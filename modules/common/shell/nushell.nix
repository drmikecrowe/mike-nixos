{ config, pkgs, lib, ... }: {

  options.nushell.enable = lib.mkEnableOption "nushell Shell History.";

  config.home-manager.users.${config.user} = lib.mkIf config.nushell.enable {

    home.packages = with pkgs; [ nushell ];

    programs.nushell = { enable = true; };

    home.file.".config/nushell/setup-carapace.nu".text = ''
      # carapace
      let carapace_completer = {|spans| 
        carapace $spans.0 nushell $spans | from json
      }

      mut current = (($env | default {} config).config | default {} completions)
      $current.completions = ($current.completions | default {} external)
      $current.completions.external = ($current.completions.external 
          | default true enable
          | default $carapace_completer completer)

      $env.config = $current

      # atuin
      # Source this in your ~/.config/nushell/config.nu
      $env.ATUIN_SESSION = (atuin uuid)

      # Magic token to make sure we don't record commands run by keybindings
      let ATUIN_KEYBINDING_TOKEN = $"# (random uuid)"

      let _atuin_pre_execution = {||
          let cmd = (commandline)
          if ($cmd | is-empty) {
              return
          }
          if not ($cmd | str starts-with $ATUIN_KEYBINDING_TOKEN) {
              $env.ATUIN_HISTORY_ID = (atuin history start -- $cmd)
          }
      }

      let _atuin_pre_prompt = {||
          let last_exit = $env.LAST_EXIT_CODE
          if 'ATUIN_HISTORY_ID' not-in $env {
              return
          }
          with-env { RUST_LOG: error } {
              atuin history end $'--exit=($last_exit)' -- $env.ATUIN_HISTORY_ID | null
          }
      }

      def _atuin_search_cmd [...flags: string] {
          [
              $ATUIN_KEYBINDING_TOKEN,
              ([
                  `commandline (RUST_LOG=error run-external --redirect-stderr atuin search`,
                  ($flags | append [--interactive, --] | each {|e| $'"($e)"'}),
                  `(commandline) | complete | $in.stderr | str substring ..-1)`,
              ] | flatten | str join ' '),
          ] | str join "\n"
      }

      $env.config = ($env | default {} config).config
      $env.config = ($env.config | default {} hooks)
      $env.config = (
          $env.config | upsert hooks (
              $env.config.hooks
              | upsert pre_execution (
                  $env.config.hooks | get -i pre_execution | default [] | append $_atuin_pre_execution)
              | upsert pre_prompt (
                  $env.config.hooks | get -i pre_prompt | default [] | append $_atuin_pre_prompt)
          )
      )

      $env.config = (
          $env.config | upsert keybindings (
              $env.config.keybindings
              | append {
                  name: atuin
                  modifier: control
                  keycode: char_r
                  mode: [emacs, vi_normal, vi_insert]
                  event: { send: executehostcommand cmd: (_atuin_search_cmd) }
              }
          )
      )

      $env.config = (
          $env.config | upsert keybindings (
              $env.config.keybindings
              | append {
                  name: atuin
                  modifier: none
                  keycode: up
                  mode: [emacs, vi_normal, vi_insert]
                  event: { send: executehostcommand cmd: (_atuin_search_cmd '--shell-up-key-binding') }
              }
          )
      )


    '';

    programs.nushell.extraConfig = ''
      source .config/nushell/setup-carapace.nu
    '';

    xdg.desktopEntries = lib.mkIf config.gui.enable {
      "kitty-nushell" = {
        name = "Nu Shell (kitty)";
        genericName = "Terminal emulator";
        exec = "kitty nu -li";
        icon = "nushell";
        categories = [ "System" "TerminalEmulator" "Utility" ];
        type = "Application";
        terminal = false;
      };
    };
  };

}
