{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./xps15-system-packages.nix
  ];

  config = {
    custom = {
      _1password = true;
      budgie = false;
      continue = true;
      discord = true;
      duplicati = true;
      flatpak = true;
      gnome = false;
      gui = true;
      kde = true;
      kitty = true;
      obsidian = true;
      vivaldi = true;

      theme = {
        colors = (import ../../colorscheme/gruvbox).light;
        dark = false;
      };
    };
  };
}
