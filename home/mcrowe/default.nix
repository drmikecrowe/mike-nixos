{
  config,
  pkgs,
  globals,
  overlays,
  home-manager,
  ...
}: 
{
  imports = [
    ../../modules/common
  ];

  config = let
    stateVersion = "23.05";
  in {
    inherit (globals) user;

    theme = {
      colors = (import ../../colorscheme/gruvbox).dark;
      dark = true;
    };
    gtk.theme.name = pkgs.lib.mkDefault "Adwaita-dark";
  };
}
