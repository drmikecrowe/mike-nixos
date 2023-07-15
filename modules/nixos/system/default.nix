{ config, pkgs, lib, ... }: {

  imports = [ ./journald.nix ./user.nix ./locale.nix ];

  config = lib.mkIf pkgs.stdenv.isLinux {

    # Pin a state version to prevent warnings
    system.stateVersion =
      config.home-manager.users.${config.user}.home.stateVersion;

    # This setting only applies to NixOS, different on Darwin
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    systemd.timers.nix-gc.timerConfig = { WakeSystem = true; };
    systemd.services.nix-gc.postStop =
      lib.mkIf (!config.server) "systemctl suspend";

  };

}
