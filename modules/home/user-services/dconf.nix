# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{lib, ...}:
with lib.hm.gvariant; {
  dconf.settings = {
    "org/gnome/Connections" = {
      first-run = false;
    };

    "org/gnome/calendar" = {
      active-view = "month";
    };

    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      cursor-size = 24;
      cursor-theme = "Numix-Cursor";
      document-font-name = "Sans 10";
      enable-animations = true;
      font-antialiasing = "rgba";
      font-hinting = "slight";
      font-name = "NotoSans NF Med,  11";
      gtk-theme = "palenight";
      icon-theme = "Papirus-Dark";
      monospace-font-name = "Noto Color Emoji 10";
      scaling-factor = mkUint32 1;
      show-battery-percentage = true;
      text-scaling-factor = 0.87;
      toolbar-style = "text";
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      disable-while-typing = true;
      edge-scrolling-enabled = true;
      send-events = false;
      tap-to-click = false;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "icon:minimize,maximize,close";
      mouse-button-modifier = "<Super>";
      titlebar-font = "Sans Bold 10";
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "Print";
      command = "flameshot gui";
      name = "Flameshot";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Control>space";
      command = "albert toggle";
      name = "albert";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = ["window-list@gnome-shell-extensions.gcampax.github.com" "space-bar@luchrioh" "launch-new-instance@gnome-shell-extensions.gcampax.github.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "quick-settings-audio-panel@rayzeq.github.io" "dash-to-dock@micxgx.gmail.com" "dock-from-dash@fthx"];
      enabled-extensions = ["BingWallpaper@ineffable-gmail.com" "quick-touchpad-toggle@kramo.hu" "quick-settings-tweaks@qwreey" "appindicatorsupport@rgcjonas.gmail.com" "apps-menu@gnome-shell-extensions.gcampax.github.com" "auto-activities@CleoMenezesJr.github.io" "custom-hot-corners-extended@G-dH.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" "systemd-manager@hardpixel.eu" "tactile@lundal.io" "Vitals@CoreCoding.com" "weatherornot@somepaulo.github.io" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "EasyScreenCast@iacopodeenosee.gmail.com" "forge@jmmaranan.com" "just-perfection-desktop@just-perfection" "no-titlebar-when-maximized@alec.ninja" "window-title-is-back@fthx"];
      favorite-apps = ["vivaldi-stable.desktop" "betterbird.desktop" "org.gnome.Music.desktop" "org.gnome.Nautilus.desktop" "authy.desktop" "org.wezfurlong.wezterm.desktop"];
      last-selected-power-profile = "performance";
      remember-mount-password = false;
      welcome-dialog-last-shown-version = "44.2";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell/extensions/appindicator" = {
      tray-pos = "right";
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
    };
  };
}
