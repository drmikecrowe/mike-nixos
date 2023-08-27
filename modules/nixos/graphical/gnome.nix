{ config, pkgs, lib, ... }:

let

  gtkTheme = {
    inherit (config.gtk.theme) name;
    package = pkgs."${config.gtk.theme.package}";
  };

in
{

  options = {
    gnome = {
      enable = lib.mkEnableOption {
        description = "Enable Gnome.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.gnome.enable {
    home-manager.users.${config.user} = {
      home = {
        packages = with pkgs; [
          dconf
          gnome.gnome-themes-extra
          gnomeExtensions.appindicator
          gnomeExtensions.auto-activities
          gnomeExtensions.custom-hot-corners-extended
          gnomeExtensions.dock-from-dash
          gnomeExtensions.quick-settings-audio-panel
          gnomeExtensions.quick-settings-tweaker
          gnomeExtensions.quick-touchpad-toggle
          gnomeExtensions.systemd-manager
          gnomeExtensions.tactile
          gnomeExtensions.vitals
          gnomeExtensions.weather-or-not
          gnomeExtensions.bing-wallpaper-changer
          gnome.libsoup
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
            # "gnomeExtensions.top-bar-organizer"
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
            "microsoft-edge.desktop"
            "code.desktop"
            "kitty-fish.desktop"
            "kitty-nushell.desktop"
          ];
        };
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          enable-hot-corners = true;
        };
        "org/gnome/desktop/wm/preferences" = { workspace-names = [ "Main" ]; };
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
      };

      gnome = { gnome-keyring = { enable = true; }; };
    };

    environment.systemPackages = with pkgs; [ gnome.gnome-tweaks ];

    services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

    security.pam.services.lightdm.enableGnomeKeyring = true;

    programs = {
      seahorse.enable = true; # keyring GUI
    };

  };

}
