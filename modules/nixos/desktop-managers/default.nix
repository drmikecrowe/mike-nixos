{ lib, ... }: {
  imports = [
    ./budgie.nix
    ./gnome.nix
    ./kde.nix
    ./xorg.nix
  ];

  options = {
    wallpaper = lib.mkOption {
      type = lib.types.path;
      description = "Wallpaper background image file";
    };
  };
}
