{
  config,
  pkgs,
  lib,
  ...
}: let
  fontName = "FiraCode";
in {
  config = lib.mkIf (config.custom.gui && pkgs.stdenv.isLinux) {
    fonts.fontDir.enable = true;
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono" "InconsolataLGC" "Noto"];})
    ];
    fonts.fontconfig.defaultFonts.monospace = [fontName];
  };
}
