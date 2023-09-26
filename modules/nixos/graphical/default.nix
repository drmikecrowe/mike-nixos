{lib, ...}: {
  imports = [
    ./applications.nix
    ./budgie.nix
    ./fonts.nix
    ./gnome.nix
    ./kde.nix
    ./nide.nix
    ./xorg.nix
  ];

  options = {
    wallpaper = lib.mkOption {
      type = lib.types.path;
      description = "Wallpaper background image file";
    };
  };
}
