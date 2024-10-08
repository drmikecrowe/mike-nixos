{
  config,
  lib,
  pkgs,
  ...
}: let
  desktopEnvironment = config.host.home.feature.gui.desktopEnvironment;
in
  with lib; {
    config = mkIf (config.host.home.feature.gui.enable && desktopEnvironment == "gnome") {
      home.packages = with pkgs; [
        dconf
        arc-theme
        gnome-themes-extra
        gnome.libsoup
        gnomeExtensions.appindicator
        gnomeExtensions.auto-activities
        gnomeExtensions.bing-wallpaper-changer
        gnomeExtensions.bing-wallpaper-changer
        gnomeExtensions.custom-hot-corners-extended
        gnomeExtensions.dash-to-dock
        gnomeExtensions.dock-from-dash
        gnomeExtensions.gtk3-theme-switcher
        gnomeExtensions.quick-settings-audio-panel
        gnomeExtensions.quick-settings-tweaker
        gnomeExtensions.quick-touchpad-toggle
        gnomeExtensions.systemd-manager
        gnomeExtensions.tactile
        gnomeExtensions.user-themes
        gnomeExtensions.vitals
        gnomeExtensions.weather-or-not
        palenight-theme
        polkit_gnome # Used to bring up authentication dialogs
        zuki-themes
        numix-cursor-theme
        material-cursors
      ];
      services = {
        gnome-keyring = {
          enable = true;
          components = [
            "pkcs11"
            "secrets"
            "ssh"
          ];
        };
      };
    };
  }
