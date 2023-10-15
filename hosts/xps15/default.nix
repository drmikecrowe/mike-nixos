{ pkgs, ... }: {
  imports = [ ./hardware.nix ];

  config = {
    gui.enable = true;
    physical = true;
    kde.enable = true;
    continue.enable = true;
    kitty.enable = true;
    _1password.enable = true;
    discord.enable = true;
    duplicati.enable = true;
    theme = {
      colors = (import ../../colorscheme/gruvbox).dark;
      dark = true;
    };
    gtk.theme.name = pkgs.lib.mkDefault "Adwaita-dark";

  };

}
