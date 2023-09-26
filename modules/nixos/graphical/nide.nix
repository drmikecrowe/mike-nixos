{
  config,
  pkgs,
  lib,
  nide,
  ...
}: {
  imports = [
    "${nide}/nix/configuration.nix"
  ];

  options = {
    nide = {
      enable = lib.mkEnableOption {
        description = "Enable nide.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.nide.enable {
    services = {
      xserver = {
        desktopManager = {
          nide = {
            enable = true;
            installPackages = true;
          };
        };
        displayManager = {
          sddm = {
            inherit (config.services.xserver) enable;
          };
        };
      };
    };
  };
}
