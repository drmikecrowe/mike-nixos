# https://github.com/wimpysworld/nix-config/blob/main/flake.nix
{
  inputs,
  outputs,
  systems,
  stateVersion,
  ...
}: {
  # Helper function for generating home-manager configs
  mkHome = {
    org,
    role,
    hostname,
    username,
    desktop,
    systems,
    platform ? "x86_64-linux",
  }: let
    dotfiles = ../home-manager/dotfiles;
    secrets = import ../secrets {
      inherit (inputs.nixpkgs) lib;
    };
    specialArgs = {
      inherit inputs outputs org role hostname username desktop stateVersion dotfiles;
      inherit (secrets.config.host) secrets;
    };
  in
    inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = specialArgs;
      modules = [
        ../home-manager/home
        ../secrets
      ];
    };

  # Helper function for generating host configs
  mkHost = {
    org,
    role,
    hostname,
    username,
    desktop,
    systems,
    platform ? "x86_64-linux",
  }: let
    secrets = import ../secrets {
      inherit (inputs.nixpkgs) lib;
    };
    dotfiles = ../home-manager/dotfiles;
    specialArgs = {
      inherit inputs outputs org role hostname username desktop stateVersion dotfiles;
      inherit (secrets.config.host) secrets;
    };
  in
    inputs.nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      # If the hostname starts with "iso-", generate an ISO image
      modules = [
        ../secrets
        ../hosts/${hostname}
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users.${username} = {
            imports = [
              ../home-manager/home
            ];
          };
        }
      ];
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs systems;
}
