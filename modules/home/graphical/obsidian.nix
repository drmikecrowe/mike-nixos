{
  custom,
  lib,
  pkgs,
  user,
  ...
}: {
  home = lib.mkIf custom.obsidian {
    packages = with pkgs; [obsidian];
  };
}
