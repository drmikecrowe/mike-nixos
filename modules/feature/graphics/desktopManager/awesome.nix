{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  config = lib.mkIf config.custom.awesome {
    # Configure keymap in X11
    environment.systemPackages = [
      pkgs.lua5_3
    ];
    services = {
      xserver = {
        displayManager = {
          sddm.enable = true;
          defaultSession = "none+awesome";
        };

        windowManager.awesome = {
          enable = true;
          luaModules = with pkgs.lua53Packages; [
            luarocks # is the package manager for Lua modules
            luadbi
            # luadbi-mysql # Database abstraction layer
          ];
        };
      };
    };
  };
}
