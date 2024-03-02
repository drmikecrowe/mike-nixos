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

    "org/gnome/control-center" = {
      last-panel = "power";
      window-state = mkTuple [1188 972 false];
    };

    "org/gnome/desktop/a11y/applications" = {
      screen-reader-enabled = false;
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/input-sources" = {
      current = mkUint32 0;
      sources = [(mkTuple ["xkb" "us"])];
      xkb-options = ["terminate:ctrl_alt_bksp"];
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
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      disable-while-typing = true;
      edge-scrolling-enabled = true;
      send-events = false;
      tap-to-click = false;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      old-files-age = mkUint32 30;
      recent-files-max-age = -1;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 900;
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "icon:minimize,maximize,close";
      mouse-button-modifier = "<Super>";
      titlebar-font = "Sans Bold 10";
    };

    "org/gnome/file-roller/listing" = {
      list-mode = "as-folder";
      name-column-width = 250;
      show-path = false;
      sort-method = "name";
      sort-type = "ascending";
    };

    "org/gnome/file-roller/ui" = {
      sidebar-width = 200;
      window-height = 469;
      window-width = 948;
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

    "org/gnome/meld/window-state" = {
      height = 2069;
      is-maximized = true;
      width = 3840;
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
      search-view = "list-view";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [1438 901];
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
      welcome-dialog-last-shown-version = "44.2";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell/extensions/appindicator" = {
      tray-pos = "right";
    };

    "org/gnome/shell/extensions/coverflowalttab" = {
      switcher-background-color = mkTuple [1.0 1.0 1.0];
    };

    "org/gnome/shell/extensions/custom-hot-corners-extended/misc" = {
      show-osd-monitor-indexes = false;
      supported-active-extensions = [];
    };

    "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-left-0" = {
      action = "show-overview";
    };

    "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-left-6" = {
      ctrl = true;
    };

    "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-right-0" = {
      action = "toggle-overview";
    };

    "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-right-6" = {
      ctrl = true;
    };

    "org/gnome/shell/extensions/forge" = {
      css-last-update = mkUint32 37;
      preview-hint-enabled = true;
      window-gap-hidden-on-single = true;
      window-gap-size = mkUint32 4;
      workspace-skip-tile = "";
    };

    "org/gnome/shell/extensions/forge/keybindings" = {
      con-split-horizontal = ["<Super>z"];
      con-split-layout-toggle = ["<Super>g"];
      con-split-vertical = ["<Super>v"];
      con-stacked-layout-toggle = ["<Shift><Super>s"];
      con-tabbed-layout-toggle = ["<Shift><Super>t"];
      con-tabbed-showtab-decoration-toggle = ["<Control><Alt>y"];
      focus-border-toggle = ["<Super>x"];
      prefs-tiling-toggle = ["<Super>w"];
      window-focus-down = ["<Super>j"];
      window-focus-left = ["<Super>h"];
      window-focus-right = ["<Super>l"];
      window-focus-up = ["<Super>k"];
      window-gap-size-decrease = ["<Control><Super>minus"];
      window-gap-size-increase = ["<Control><Super>plus"];
      window-move-down = ["<Shift><Super>j"];
      window-move-left = ["<Shift><Super>h"];
      window-move-right = ["<Shift><Super>l"];
      window-move-up = ["<Shift><Super>k"];
      window-resize-bottom-decrease = ["<Shift><Control><Super>i"];
      window-resize-bottom-increase = ["<Control><Super>u"];
      window-resize-left-decrease = ["<Shift><Control><Super>o"];
      window-resize-left-increase = ["<Control><Super>y"];
      window-resize-right-decrease = ["<Shift><Control><Super>y"];
      window-resize-right-increase = ["<Control><Super>o"];
      window-resize-top-decrease = ["<Shift><Control><Super>u"];
      window-resize-top-increase = ["<Control><Super>i"];
      window-snap-center = ["<Control><Alt>c"];
      window-snap-one-third-left = ["<Control><Alt>d"];
      window-snap-one-third-right = ["<Control><Alt>g"];
      window-snap-two-third-left = ["<Control><Alt>e"];
      window-snap-two-third-right = ["<Control><Alt>t"];
      window-swap-down = ["<Control><Super>j"];
      window-swap-last-active = ["<Super>Return"];
      window-swap-left = ["<Control><Super>h"];
      window-swap-right = ["<Control><Super>l"];
      window-swap-up = ["<Control><Super>k"];
      window-toggle-always-float = ["<Shift><Super>c"];
      window-toggle-float = ["<Super>c"];
      workspace-active-tile-toggle = ["<Shift><Super>w"];
    };

    "org/gnome/shell/extensions/just-perfection" = {
      accessibility-menu = false;
      dash-icon-size = 16;
      keyboard-layout = false;
      panel = true;
      panel-in-overview = true;
      ripple-box = false;
      search = false;
      show-apps-button = false;
      startup-status = 0;
      theme = true;
      window-demands-attention-focus = true;
      window-picker-icon = false;
      workspace = false;
      workspaces-in-app-grid = false;
      world-clock = false;
    };

    "org/gnome/shell/extensions/libpanel" = {
      layout = [["gnome@main"]];
    };

    "org/gnome/shell/extensions/quick-settings-audio-panel" = {
      always-show-input-slider = true;
      media-control = "none";
      merge-panel = true;
    };

    "org/gnome/shell/extensions/quick-settings-tweaks" = {
      datemenu-fix-weather-widget = true;
      input-show-selected = true;
      list-buttons = "[{\"name\":\"SystemItem\",\"title\":null,\"visible\":true},{\"name\":\"OutputStreamSlider\",\"title\":null,\"visible\":true},{\"name\":\"InputStreamSlider\",\"title\":null,\"visible\":false},{\"name\":\"BrightnessItem\",\"title\":null,\"visible\":true},{\"name\":\"NMWiredToggle\",\"title\":null,\"visible\":false},{\"name\":\"NMWirelessToggle\",\"title\":\"Wi-Fi\",\"visible\":true},{\"name\":\"NMModemToggle\",\"title\":null,\"visible\":false},{\"name\":\"NMBluetoothToggle\",\"title\":null,\"visible\":false},{\"name\":\"NMVpnToggle\",\"title\":\"VPN\",\"visible\":true},{\"name\":\"BluetoothToggle\",\"title\":\"Bluetooth\",\"visible\":true},{\"name\":\"PowerProfilesToggle\",\"title\":\"Power Mode\",\"visible\":true},{\"name\":\"NightLightToggle\",\"title\":\"Night Light\",\"visible\":true},{\"name\":\"DarkModeToggle\",\"title\":\"Dark Style\",\"visible\":true},{\"name\":\"KeyboardBrightnessToggle\",\"title\":\"Keyboard\",\"visible\":true},{\"name\":\"RfkillToggle\",\"title\":\"Airplane Mode\",\"visible\":true},{\"name\":\"RotationToggle\",\"title\":\"Auto Rotate\",\"visible\":false},{\"name\":\"FeatureToggle\",\"title\":\"Touchpad\",\"visible\":true},{\"name\":\"DndQuickToggle\",\"title\":\"Do Not Disturb\",\"visible\":true},{\"name\":\"BackgroundAppsToggle\",\"title\":\"No Background Apps\",\"visible\":false},{\"name\":\"MediaSection\",\"title\":null,\"visible\":false},{\"name\":\"Notifications\",\"title\":null,\"visible\":true},{\"name\":\"St_BoxLayout\",\"title\":null,\"visible\":true}]";
      output-show-selected = true;
      user-removed-buttons = ["BluetoothToggle" "PowerProfilesToggle" "DarkModeToggle" "QuickSettingsPanel"];
      volume-mixer-filter-mode = "allow";
      volume-mixer-position = "bottom";
    };

    "org/gnome/shell/extensions/systemd-manager" = {
      systemd = [
        ''
          {"name":"Avahi","service":"avahi-daemon.service","type":"system"}\\n\n
        ''
        ''
          {"name":"flatpak-portal.service","service":"flatpak-portal.service","type":"user"}\\n\n
        ''
        ''
          {"name":"flatpak-session-helper.service","service":"flatpak-session-helper.service","type":"user"}\\n\n
        ''
      ];
    };

    "org/gnome/shell/extensions/tactile" = {
      col-2 = 0;
      col-3 = 0;
      layout-2-row-2 = 0;
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Zuki-shell";
    };

    "org/gnome/shell/extensions/vitals" = {
      show-fan = true;
      show-memory = true;
      show-network = true;
      show-processor = true;
      show-storage = false;
      show-temperature = true;
      show-voltage = true;
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [];
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
    };

    "org/gnome/shell/world-clocks" = {
      locations = [];
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };
  };
}
