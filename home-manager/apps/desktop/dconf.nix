{ config, pkgs, lib, ... }:

{
  home = {
    packages = with pkgs; [
      dconf
      gnomeExtensions.appindicator
      gnomeExtensions.auto-activities
      gnomeExtensions.custom-hot-corners-extended
      gnomeExtensions.dock-from-dash
      gnomeExtensions.quick-settings-audio-panel
      gnomeExtensions.quick-settings-tweaker
      gnomeExtensions.systemd-manager
      gnomeExtensions.tactile
      gnomeExtensions.vitals
      gnomeExtensions.weather-or-not
      gnomeExtensions.top-bar-organizer
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
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "custom-hot-corners-extended@G-dH.github.com"
        "dock-from-dash@fthx"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "gnomeExtensions.top-bar-organizer"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        "quick-settings-audio-panel@rayzeq.github.io"
        "quick-settings-tweaks@qwreey"
        "systemd-manager@hardpixel.eu"
        "tactile@lundal.io"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "weatherornot@somepaulo.github.io"
      ];
      favorite-apps = [
        "vivaldi-stable.desktop"
        "code.desktop"
        "kitty-fish.desktop"
        "kitty-nushell.desktop"
        "wavebox.desktop"
      ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      workspace-names = [ "Main" ];
    };
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

}
