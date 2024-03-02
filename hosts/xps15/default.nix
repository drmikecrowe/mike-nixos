{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./options/nvidia.nix
    # ./options/kernel.nix # zfs kernel packages if nvidia not selected
    ./xps15-system-packages.nix
  ];

  config = {
    custom = {
      _1password = true;
      budgie = true;
      continue = true;
      discord = true;
      duplicati = true;
      flatpak = true;
      gnome = false;
      gui = true;
      kde = false;
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
