{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  config = lib.mkIf config.custom.budgie {
    home-manager.users.${user} = {
      home = {
        packages = with pkgs; [
          dconf
          budgie.budgie-desktop-with-plugins
        ];
      };
    };

    # Configure keymap in X11
    services = {
      xserver = {
        desktopManager = {budgie = {enable = true;};};
      };
    };
  };
}
