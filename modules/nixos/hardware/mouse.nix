{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf config.custom.gui {
    services.xserver = {
      libinput.mouse = {
        # Disable mouse acceleration
        accelProfile = "flat";
        accelSpeed = "1.15";
      };

      # Enable touchpad support (enabled default in most desktopManager).
      # synaptics = {
      #   enable = true;
      #   palmDetect = true;
      #   twoFingerScroll = true;
      #   minSpeed = "1.0";
      #   maxSpeed = "1.12";
      #   accelFactor = "0.01";
      # };
    };
  };
}
