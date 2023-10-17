{ custom
, lib
, pkgs
, user
, ...
}: {
  home = lib.mkIf custom.obsidian.enable {
    packages = with pkgs; [ obsidian ];
  };
}
