{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  options = {
    gtk.theme = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "Theme name for GTK applications";
        default = "Adwaita";
      };
      package = lib.mkOption {
        type = lib.types.str;
        description = "Theme package name for GTK applications";
        default = "gnome-themes-extra";
      };
    };
  };

  config = lib.mkIf config.custom.gui {
    # Enable the X11 windowing system.
    services = {
      xserver = {
        enable = true;
      };
      dbus.packages = [pkgs.dconf];
    };

    # Required for setting GTK theme (for preferred-color-scheme in browser)
    programs = {
      dconf.enable = true;
    };

    environment = {
      sessionVariables = {
        GTK_THEME = config.gtk.theme.name;
      };
    };
  };
}
