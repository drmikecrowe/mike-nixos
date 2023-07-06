{ config, pkgs, inputs, system, ... }:

{
  # Configure keymap in X11
  services.xserver = {
    displayManager = {
      lightdm = {
        enable = true;
        greeter = {
          enable = true;
        };
        greeters = {
          enso = {
            enable = true;
            blur = true;
          };
          # slick = {
          #   enable = true;
          # };
        };
      };
    };
  };
}
