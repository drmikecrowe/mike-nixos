{ inputs, pkgs, ... }: {
  imports = [ ./hardware.nix ];

  config = {
    custom = {
      gui.enable = true;
      continue.enable = true;
      kde.enable = true;
      kitty.enable = true;
      _1password.enable = true;
      discord.enable = true;
      duplicati.enable = true;
      theme = {
        colors = (import ../../colorscheme/gruvbox).light;
        dark = false;
      };
    };
    gtk.theme.name = pkgs.lib.mkDefault "Adwaita";
    environment.systemPackages = [
      inputs.devenv.packages.${pkgs.system}.devenv
    ];
  };

}
