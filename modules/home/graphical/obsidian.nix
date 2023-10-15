{ config
, lib
, pkgs
, ...
}: {
  home = lib.mkIf config.obsidian.enable {
    home.packages = with pkgs; [ obsidian ];

    # Broken on 2023-04-16
    nixpkgs.config.permittedInsecurePackages = [ "electron-21.4.0" ];
  };
}
