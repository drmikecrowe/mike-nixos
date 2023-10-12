{ config
, pkgs
, lib
, ...
}:
let
  fontName = "FiraCode";
in
{
  config = lib.mkIf (config.gui.enable && pkgs.stdenv.isLinux) {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "InconsolataLGC" "Noto" ]; })
    ];
    fonts.fontconfig.defaultFonts.monospace = [ fontName ];
  };
}
