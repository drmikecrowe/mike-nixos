{
  config,
  inputs,
  lib,
  pkgs,
  specialArgs,
  ...
}:
with lib; let
  graphics = config.host.feature.graphics;
in {
  config = mkIf (graphics.enable && graphics.backend == "wayland") {
    environment.pathsToLink = ["/libexec"];

    environment.systemPackages = with pkgs; [
      pinentry-qt
      xclip
    ];
    programs = {
      dconf.enable = mkDefault true;
    };

    security = mkIf (config.host.role != "kiosk") {
      pam = {
        services.gdm.enableGnomeKeyring = mkDefault true;
        services.swaylock.text = mkDefault ''
          # PAM configuration file for the swaylock screen locker. By default, it includes
          # the 'login' configuration file (see /etc/pam.d/login)
          auth include login
        '';
      };
      polkit = {
        enable = mkDefault true;
      };
    };

    services = {
      gvfs = {
        enable = mkDefault true;
      };

      gnome.gnome-keyring = {
        enable = mkDefault true;
      };

      libinput = {
        enable = true;
        mouse = {
          # Disable mouse acceleration
          accelProfile = "flat";
          accelSpeed = "1.5";
        };
        touchpad = mkDefault {
          disableWhileTyping = true;
          tapping = false;
        };
      };

      xserver = {
        enable = mkDefault true;
        desktopManager = {
          xterm.enable = mkDefault false;
        };
        xkb.layout = mkDefault "us";

        # Keyboard responsiveness
        autoRepeatDelay = mkDefault 250;
        autoRepeatInterval = mkDefault 40;
      };
    };
  };
}
