{ config, pkgs, inputs, system, ... }:

{
  services.xserver = {
    enable = true;
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
        };
      };
    };
  };
}
