{
  inputs,
  pkgs,
  disko,
  ...
}: {
  imports = [
    ./hardware.nix
    ./options/nvidia.nix
    # ./options/kernel.nix # zfs kernel packages if nvidia not selected
    disko.nixosModules.disko
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
      nvidia = true;

      theme = {
        colors = (import ../../colorscheme/gruvbox).light;
        dark = false;
      };
    };
  };
}
