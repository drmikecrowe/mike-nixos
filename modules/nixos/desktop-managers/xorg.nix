{ config
, pkgs
, lib
, user
, ...
}: {
  options = {
    gtk.theme = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "Theme name for GTK applications";
      };
      package = lib.mkOption {
        type = lib.types.str;
        description = "Theme package name for GTK applications";
        default = "gnome-themes-extra";
      };
    };
  };

  config =
    let
      gtkTheme = {
        inherit (config.gtk.theme) name;
        package = pkgs."${config.gtk.theme.package}";
      };
    in
    lib.mkIf config.gui.enable {
      # Enable the X11 windowing system.
      services.xserver = {
        inherit (config.gui) enable;
      };

      environment.systemPackages = with pkgs; [
        xclip # Clipboard
      ];

      # Required for setting GTK theme (for preferred-color-scheme in browser)
      services.dbus.packages = [ pkgs.dconf ];
      programs.dconf.enable = true;

      environment.sessionVariables = { GTK_THEME = config.gtk.theme.name; };
    };
}
