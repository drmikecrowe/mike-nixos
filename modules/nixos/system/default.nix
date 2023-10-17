{ config
, pkgs
, user
, lib
, ...
}: {
  imports = [
    ./fonts.nix
    ./journald.nix
    ./locale.nix
    ./nix.nix
    ./user.nix
    ./virtualization.nix
  ];
}
