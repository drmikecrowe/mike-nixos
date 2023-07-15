{ config, pkgs, lib, ... }:

let fontName = "Victor Mono";

in {

  config = lib.mkIf (config.gui.enable && pkgs.stdenv.isLinux) {

    fonts.fonts = with pkgs; [
      victor-mono # Used for Vim and Terminal
      (nerdfonts.override {
        fonts = [ "Hack" "FiraCode" ];
      }) # For Polybar, Rofi
    ];
    fonts.fontconfig.defaultFonts.monospace = [ fontName ];

    home-manager.users.${config.user} = {
      services.polybar.config."bar/main".font-0 = "Hack Nerd Font:size=10;2";
      programs.kitty.font.name = fontName;
    };

  };

}
