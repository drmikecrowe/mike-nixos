# https://github.com/wimpysworld/nix-config/blob/main/flake.nix
{
  inputs,
  outputs,
  stateVersion,
  ...
}: {
  # Helper function for generating home-manager configs
  mkHome = {
    org,
    role,
    hostname,
    username,
    nur,
    desktop,
  }: let
    dotfiles = ../home-manager/dotfiles;
    secrets = import ../secrets {
      inherit (inputs.nixpkgs) lib;
    };
    specialArgs = {
      inherit inputs outputs org role hostname username desktop stateVersion dotfiles nur;
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
    nur,
    desktop,
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
        nur.nixosModules.nur
        ../secrets
        ../hosts/${hostname}
        inputs.flatpaks.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            users.${username}.imports = [
              ../home-manager/home
            ];
          };
        }
      ];
    };
}
