{ config, pkgs, lib, ... }: {

  options.nushell.enable = lib.mkEnableOption "nushell Shell History.";

  config.home-manager.users.${config.user} = lib.mkIf config.nushell.enable {

    home.packages = with pkgs; [ nushell ];

    programs.nushell = { enable = true; };

    home.file.".config/nushell/setup-carapace.nu".text = ''
      let carapace_completer = {|spans| 
        carapace $spans.0 nushell $spans | from json
      }

      mut current = (($env | default {} config).config | default {} completions)
      $current.completions = ($current.completions | default {} external)
      $current.completions.external = ($current.completions.external 
          | default true enable
          | default $carapace_completer completer)

      $env.config = $current
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
