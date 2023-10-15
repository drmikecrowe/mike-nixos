{ osConfig
, lib
, pkgs
, user
, ...
}: {
  home = lib.mkIf osConfig.obsidian.enable {
    packages = with pkgs; [ obsidian ];
  };
}
