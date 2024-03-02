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
      # Always defaulted on this machine
      _1password = true;
      continue = true;
      discord = true;
      duplicati = true;
      flatpak = true;
      gui = true;
      kitty = true;
      obsidian = true;
      vivaldi = true;

      # Window Manager: awesome, budgie, kde, gnome
      gnome = true;

      theme = {
        colors = (import ../../colorscheme/gruvbox).light;
        dark = false;
      };
    };
  };
}
