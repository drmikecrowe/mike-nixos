{ lib, ... }: {

  imports = [
    ./applications.nix
    ./budgie.nix
    ./dunst.nix
    ./fonts.nix
    ./gnome.nix
    ./kde.nix
    ./lightdm.nix
    ./sddm.nix
    ./gdm.nix
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
