{ lib, ... }: {

  imports = [ ./applications.nix ./dunst.nix ./fonts.nix ./gnome.nix ./xorg.nix ];

  options = {

    wallpaper = lib.mkOption {
      type = lib.types.path;
      description = "Wallpaper background image file";
    };

  };

}