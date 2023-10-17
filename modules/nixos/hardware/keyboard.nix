{ config, ... }: {
  config = {
    services.xserver = {
      layout = "us";

      # Keyboard responsiveness
      autoRepeatDelay = 250;
      autoRepeatInterval = 40;
    };
  };
}
