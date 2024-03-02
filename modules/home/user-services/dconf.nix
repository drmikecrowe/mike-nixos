# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{lib, ...}:
with lib.hm.gvariant; {
  dconf.settings = {
    "org/blueman/general" = {
      plugin-list = ["!ConnectionNotifier"];
      window-properties = [1920 596 0 30];
    };

    "org/gnome/Connections" = {
      first-run = false;
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/mcrowe/Pictures/BingWallpaper/20240227-PolarBearCubs_EN-US3160537454_UHD.jpg";
      picture-uri-dark = "file:///home/mcrowe/Pictures/BingWallpaper/20240227-PolarBearCubs_EN-US3160537454_UHD.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
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
      text-scaling-factor = 0.8699999999999999;
      toolbar-style = "text";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      disable-while-typing = true;
      edge-scrolling-enabled = true;
      send-events = false;
      tap-to-click = false;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/mcrowe/.local/share/backgrounds/2023-07-29-12-21-51-20220830-Migliarino_EN-US6999892958_UHD.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/meld" = {
      custom-font = "FiraCode Nerd Font Mono Light 14";
      enable-space-drawer = true;
      filename-filters = [(mkTuple ["Backups" true "#*# .#* ~* *~ *.{orig,bak,swp}"]) (mkTuple ["OS-specific metadata" true ".DS_Store ._* .Spotlight-V100 .Trashes Thumbs.db Desktop.ini node_modules .direnv .history .serverless result"]) (mkTuple ["Version Control" true "_MTN .bzr .svn .svn .hg .fslckout _FOSSIL_ .fos CVS _darcs .git .svn .osc"]) (mkTuple ["Binaries" true "*.{pyc,a,obj,o,so,la,lib,dll,exe}"]) (mkTuple ["Media" false "*.{jpg,gif,png,bmp,wav,mp3,ogg,flac,avi,mpg,xcf,xpm}"]) (mkTuple ["node" true "node_modules .yarn dist .pnpm-store .esbuild"])];
      indent-width = 2;
      insert-spaces-instead-of-tabs = true;
      prefer-dark-theme = true;
      show-line-numbers = true;
      style-scheme = "cobalt";
      use-system-font = false;
      wrap-mode = "none";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Control>space";
      command = "albert toggle";
      name = "albert";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = ["BingWallpaper@ineffable-gmail.com" "quick-touchpad-toggle@kramo.hu" "quick-settings-tweaks@qwreey" "appindicatorsupport@rgcjonas.gmail.com" "apps-menu@gnome-shell-extensions.gcampax.github.com" "auto-activities@CleoMenezesJr.github.io" "custom-hot-corners-extended@G-dH.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" "systemd-manager@hardpixel.eu" "tactile@lundal.io" "Vitals@CoreCoding.com" "weatherornot@somepaulo.github.io" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "dock-from-dash@fthx" "dash-to-dock@micxgx.gmail.com"];
      favorite-apps = ["vivaldi-stable.desktop" "betterbird.desktop" "org.gnome.Music.desktop" "org.gnome.Nautilus.desktop" "authy.desktop" "org.wezfurlong.wezterm.desktop"];
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell/extensions/quick-settings-audio-panel" = {
      always-show-input-slider = true;
      media-control = "none";
      merge-panel = true;
    };

    "org/gnome/shell/extensions/quick-settings-tweaks" = {
      datemenu-fix-weather-widget = true;
      input-show-selected = true;
      list-buttons = "[{\"name\":\"SystemItem\",\"title\":null,\"visible\":true},{\"name\":\"BrightnessItem\",\"title\":null,\"visible\":true},{\"name\":\"NMWiredToggle\",\"title\":null,\"visible\":false},{\"name\":\"NMWirelessToggle\",\"title\":\"Wi-Fi\",\"visible\":true},{\"name\":\"NMModemToggle\",\"title\":null,\"visible\":false},{\"name\":\"NMBluetoothToggle\",\"title\":null,\"visible\":false},{\"name\":\"NMVpnToggle\",\"title\":\"VPN\",\"visible\":true},{\"name\":\"BluetoothToggle\",\"title\":\"Bluetooth\",\"visible\":true},{\"name\":\"PowerProfilesToggle\",\"title\":\"Power Mode\",\"visible\":true},{\"name\":\"NightLightToggle\",\"title\":\"Night Light\",\"visible\":true},{\"name\":\"DarkModeToggle\",\"title\":\"Dark Style\",\"visible\":true},{\"name\":\"KeyboardBrightnessToggle\",\"title\":\"Keyboard\",\"visible\":true},{\"name\":\"RfkillToggle\",\"title\":\"Airplane Mode\",\"visible\":true},{\"name\":\"RotationToggle\",\"title\":\"Auto Rotate\",\"visible\":false},{\"name\":\"FeatureToggle\",\"title\":\"Touchpad\",\"visible\":true},{\"name\":\"DndQuickToggle\",\"title\":\"Do Not Disturb\",\"visible\":true},{\"name\":\"BackgroundAppsToggle\",\"title\":\"No Background Apps\",\"visible\":false},{\"name\":\"OutputStreamSlider\",\"title\":null,\"visible\":true},{\"name\":\"InputStreamSlider\",\"title\":null,\"visible\":true},{\"name\":\"Clutter_Actor\",\"title\":null,\"visible\":false},{\"name\":\"MediaSection\",\"title\":null,\"visible\":false},{\"name\":\"Notifications\",\"title\":null,\"visible\":true},{\"name\":\"St_BoxLayout\",\"title\":null,\"visible\":true}]";
      output-show-selected = true;
      user-removed-buttons = ["BluetoothToggle" "PowerProfilesToggle" "DarkModeToggle" "QuickSettingsPanel"];
      volume-mixer-filter-mode = "allow";
      volume-mixer-position = "bottom";
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
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

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };
  };
}
