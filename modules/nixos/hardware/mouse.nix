{ config, pkgs, lib, ... }: {

  config = lib.mkIf config.gui.enable {

    services.xserver.libinput.mouse = {
      # Disable mouse acceleration
      accelProfile = "flat";
      accelSpeed = "1.15";
    };

  };

}
