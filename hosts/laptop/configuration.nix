{ pkgs, ... }:


let
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/master.tar.gz";
in
{
  imports = [
    "${impermanence}/nixos.nix"
    ./hardware-configuration.nix
    ./9650.nix
    #./nvidia.nix
    ./zfs.nix
    ./networking.nix
    ./services.nix
    ./system-config.nix
    ./system-pkgs.nix
    ./persist.nix
    ./location.nix
    ../users/root.nix
    ../users/mcrowe.nix
    ../shared/vim.nix
  ];

  system.stateVersion = "23.05";

}
