{ inputs, pkgs, ... }: {

  config = {
    custom = {
      kitty.enable = true;
      _1password.enable = true;
      theme = {
        colors = (import ../../colorscheme/gruvbox).light;
        dark = false;
      };
    };
    gtk.theme.name = pkgs.lib.mkDefault "Adwaita";
  };

}
