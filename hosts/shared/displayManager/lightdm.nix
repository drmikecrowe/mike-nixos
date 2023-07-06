{ config, pkgs, inputs, system, ... }:

{
  # Configure keymap in X11
  services.xserver = {
    displayManager = {
      lightdm = {
        enable = true;
        greeter = {
          enable = true;
          theme = "lightdm-webkit2-greeter";
          webkit2 = {
            enable = true;
            theme = "material2";
          };
        };
      };
    };
  };
}
