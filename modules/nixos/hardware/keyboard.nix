{config, ...}: {
  config = {
    services.xserver = {
      xkb.layout = "us";

      # Keyboard responsiveness
      autoRepeatDelay = 250;
      autoRepeatInterval = 40;
    };
  };
}
