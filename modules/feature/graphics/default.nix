{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./backend
    ./desktopManager
    ./displayManager
  ];

  options = {
    host.feature.graphics = {
      enable = lib.mkOption {
        default = false;
        type = with lib.types; bool;
        description = "Enables Graphics Support";
      };
      acceleration = lib.mkOption {
        default = false;
        type = with lib.types; bool;
        description = "Enables graphics acceleration";
      };
      backend = lib.mkOption {
        type = lib.types.enum ["x" "wayland" null];
        default = null;
        description = "Backend of displayManager";
      };
      monitors = lib.mkOption {
        type = with lib.types; listOf str;
        default = [];
        description = "Declare the order of monitors in Window manager configurations";
      };
      desktopManager = lib.mkOption {
        type = lib.types.enum ["gnome" "kde" "kde6" "budgie" "cinnamon" "deepin" null];
        default = null;
        description = "Desktop Manager to use";
      };
      displayManager = {
        autoLogin = {
          enable = lib.mkOption {
            default = false;
            type = with lib.types; bool;
            description = "Automatically log a user into a session";
          };
          user = lib.mkOption {
            type = with lib.types; str;
            description = "User to auto login";
          };
        };
        manager = lib.mkOption {
          type = lib.types.enum ["greetd" "gdm" "lightdm" "sddm" null];
          default = "lightdm";
          description = "Display Manager to use";
        };
        session = lib.mkOption {
          type = lib.types.listOf lib.types.attrs;
          default = [];
          description = "Sessions that should be available to access via displayManager";
        };
      };
    };
  };

  config = {
    hardware = {
      graphics = lib.mkIf ((config.host.feature.graphics.enable) && (config.host.feature.graphics.acceleration)) {
        enable = true;
      };
    };
  };
}
