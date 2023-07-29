{ config, pkgs, lib, ... }:

let fontName = "FiraCode";

in
{

  config = lib.mkIf (config.gui.enable && pkgs.stdenv.isLinux) {

    fonts.fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    ];
    fonts.fontconfig.defaultFonts.monospace = [ fontName ];

    home-manager.users.${config.user} = {
      programs.kitty.font.name = fontName;
    };

  };

}
