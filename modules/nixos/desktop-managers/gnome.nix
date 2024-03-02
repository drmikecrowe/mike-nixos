{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  config = lib.mkIf config.custom.gnome {
    home-manager.users.${user} = {
      home = {
        packages = with pkgs; [
          dconf
          gnome.gnome-themes-extra
          gnome.libsoup
          gnomeExtensions.appindicator
          gnomeExtensions.auto-activities
          gnomeExtensions.bing-wallpaper-changer
          gnomeExtensions.custom-hot-corners-extended
          gnomeExtensions.dock-from-dash
          gnomeExtensions.quick-settings-audio-panel
          gnomeExtensions.quick-settings-tweaker
          gnomeExtensions.quick-touchpad-toggle
          gnomeExtensions.systemd-manager
          gnomeExtensions.tactile
          gnomeExtensions.user-themes
          gnomeExtensions.vitals
          gnomeExtensions.weather-or-not
          gnomeExtensions.dash-to-dock
          gnomeExtensions.bing-wallpaper-changer
          palenight-theme
        ];
      };
    };

    # Configure keymap in X11
    services = {
      xserver = {
        desktopManager = {
          gnome = {
            enable = true;
          };
        };
        displayManager = {
          lightdm = {
            inherit (config.services.xserver) enable;
            # background = config.wallpaper;

            # Make the login screen dark
            greeters = {
              slick.enable = false;
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

      gnome = {gnome-keyring = {enable = true;};};
    };

    environment.systemPackages = with pkgs; [gnome.gnome-tweaks];

    services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];

    security.pam.services.lightdm.enableGnomeKeyring = true;

    programs = {
      seahorse.enable = true; # keyring GUI
    };
  };
}
