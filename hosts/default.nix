{
  lib,
  inputs,
  dotfiles,
  hosts,
  systems,
  isNixOS,
  isHardware,
  user,
  nixpkgs,
  home-manager,
  ...
}: let
  mkHost = {
    host,
    stateVersion,
    system,
    timezone,
    extraOverlays,
    extraModules,
  }: isNixOS: isHardware: let
    inherit (inputs) self;
    inherit (self.nixosConfigurations.xps15.config) custom;
    secrets = import ../secrets;
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowBroken = true;
        allowUnfree = true;
        allowUnsupportedSystem = true;
        nvidia.acceptLicense = true;
        permittedInsecurePackages = [
          "mailspring-1.11.0"
          "electron-25.9.0"
          "electron-19.1.9"
        ];
      };
      overlays =
        [
          (import ../overlays)
          (import ../packages)
        ]
        ++ extraOverlays;
    };

    extraArgs = {
      inherit (self.nixosConfigurations.xps15.config) custom;
      inherit pkgs inputs isHardware user dotfiles timezone system stateVersion secrets;
      hostname = host;
    };

    extraSpecialModules = extraModules;
  in
    if isNixOS
    then
      nixpkgs.lib.nixosSystem
      {
        inherit system;
        specialArgs = extraArgs;
        modules =
          [
            ../modules/options.nix
            (
              {config, ...}: {
                custom.secrets = import ../secrets;
              }
            )
            ./configuration.nix
            ./${host}
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = extraArgs;
              home-manager.users.${user} = {
                imports = [
                  ./home.nix
                  ./${host}/home.nix
                ];
                home.stateVersion = stateVersion;
              };
            }

            inputs.nix-snapd.nixosModules.default
            {
              services.snap.enable = true;
            }
          ]
          ++ extraSpecialModules;
      }
    else
      home-manager.lib.homeManagerConfiguration
      {
        inherit pkgs;
        extraSpecialArgs = extraArgs;
        modules = [
          ./home.nix
          ./${host}/home.nix
          (_: {
            home.username = user;
            home.homeDirectory = "/home/${user}";
            home.stateVersion = stateVersion;
          })
        ];
      };

  systemsPermutatedHosts = lib.concatMap (system: map (host: host // system) hosts) systems;
  permutatedHosts = systemsPermutatedHosts;
in
  /*
  We have a list of sets.
  Map each element of the list applying the mkHost function to its elements and returning a set in the listToAttrs format
  builtins.listToAttrs on the result
  */
  builtins.listToAttrs (map
    (mInput @ {
      host,
      system,
      ...
    }: {
      name =
        if isNixOS
        then host
        else user;
      value = mkHost mInput isNixOS isHardware;
    })
    permutatedHosts)
