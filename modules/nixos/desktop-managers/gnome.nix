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
          palenight-theme
        ];
      };

      # Use `dconf watch /` to track stateful changes you are doing and store them here.
      dconf.settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          # `gnome-extensions list` for a list
          enabled-extensions = [
            "Vitals@CoreCoding.com"
            "appindicatorsupport@rgcjonas.gmail.com"
            "auto-activities@CleoMenezesJr.github.io"
            "custom-hot-corners-extended@G-dH.github.com"
            "dock-from-dash@fthx"
            "drive-menu@gnome-shell-extensions.gcampax.github.com"
            "native-window-placement@gnome-shell-extensions.gcampax.github.com"
            "quick-settings-audio-panel@rayzeq.github.io"
            "quick-settings-tweaks@qwreey"
            "systemd-manager@hardpixel.eu"
            "tactile@lundal.io"
            "user-theme@gnome-shell-extensions.gcampax.github.com"
            "weatherornot@somepaulo.github.io"
            "gnomeExtensions.bing-wallpaper-changer"
          ];
          favorite-apps = [
            "firefox.desktop"
            "code.desktop"
          ];
          "org/gnome/shell/extensions/user-theme" = {
            name = "palenight";
          };
        };
        "org/gnome/desktop/interface" = {
          # color-scheme = "prefer-dark";
          enable-hot-corners = true;
        };
        "org/gnome/desktop/wm/preferences" = {workspace-names = ["Main"];};
        "org/gnome/shell/extensions/vitals" = {
          show-storage = false;
          show-voltage = true;
          show-memory = true;
          show-fan = true;
          show-temperature = true;
          show-processor = true;
          show-network = true;
        };
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
          gdm = {
            inherit (config.services.xserver) enable;
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
