{ config, pkgs, lib, ... }: {

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

        # Enable touchpad support
        libinput = {
          enable = true;
          touchpad.tapping = true;
        };

        # Login screen
        displayManager = {
          lightdm = {
            inherit (config.services.xserver) enable;
            # background = config.wallpaper;

            # Make the login screen dark
            greeters = {
              gtk.theme = gtkTheme;
              enso = {
                enable = true;
                blur = true;
              };
            };

            # Show default user
            extraSeatDefaults = ''
              greeter-hide-users = false
            '';

          };
        };

      };

      environment.systemPackages = with pkgs;
        [
          xclip # Clipboard
        ];

      # Required for setting GTK theme (for preferred-color-scheme in browser)
      services.dbus.packages = [ pkgs.dconf ];
      programs.dconf.enable = true;

      environment.sessionVariables = { GTK_THEME = config.gtk.theme.name; };

      home-manager.users.${config.user} = {

        home.shellAliases = {
          pbcopy = "xclip -selection clipboard -in";
          pbpaste = "xclip -selection clipboard -out";
        };

        gtk =
          let
            gtkExtraConfig = {
              gtk-application-prefer-dark-theme = config.theme.dark;
            };
          in
          {
            enable = true;
            theme = gtkTheme;
            gtk3.extraConfig = gtkExtraConfig;
            gtk4.extraConfig = gtkExtraConfig;
          };

      };

    };

}
