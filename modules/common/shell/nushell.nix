{ config, pkgs, lib, ... }: {

  options.nushell.enable = lib.mkEnableOption "nushell Shell History.";

  config.home-manager.users.${config.user} = lib.mkIf config.nushell.enable {

    home.packages = with pkgs; [ nushell ];

    programs.nushell = { enable = true; };

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
  # lib.mkIf config.carapace.enable 

}
