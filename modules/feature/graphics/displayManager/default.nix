{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.feature.graphics.displayManager;
in
  with lib; {
    imports = [
      ./gdm.nix
      ./greetd.nix
      ./lightdm.nix
      ./sddm.nix
    ];

    config = mkIf (config.host.feature.graphics.enable) {
      host.feature.graphics.displayManager.session = mkIf (config.host.feature.home-manager.enable) [
        {
          name = "home-manager";
          start = ''
            ${pkgs.runtimeShell} $HOME/.hm-xsession &
            waitPID=$!
          '';
        }
      ];

      services = {
        xserver = {
          desktopManager = {
            session = [] ++ config.host.feature.graphics.displayManager.session;
          };
          displayManager = mkIf (cfg.autoLogin.enable) {
            autoLogin = {
              enable = mkDefault true;
              user = cfg.autoLogin.user;
            };
          };
        };
      };
    };
  }
