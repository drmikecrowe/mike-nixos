{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./virtualization.nix
    ./journald.nix
    ./user.nix
    ./locale.nix
    ./nix.nix
  ];

  config = lib.mkIf pkgs.stdenv.isLinux {
    # Pin a state version to prevent warnings
    system.stateVersion =
      config.home-manager.users.${config.user}.home.stateVersion;
  };
}
