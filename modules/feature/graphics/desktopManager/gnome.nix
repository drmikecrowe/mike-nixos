{
  config,
  pkgs,
  lib,
  user,
  ...
}:
with lib; let
  graphics = config.host.feature.graphics;
in {
  config = lib.mkIf (graphics.enable && graphics.desktopManager == "gnome") {
    # Configure keymap in X11
    services = {
      xserver = {
        desktopManager = {
          gnome = {
            enable = true;
          };
        };
      };
    };

    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
      gparted
      gtk3
      gtk4
    ];

    services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];
  };
}
