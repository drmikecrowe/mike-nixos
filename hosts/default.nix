{
  lib,
  inputs,
  secrets,
  dotfiles,
  hosts,
  systems,
  isNixOS,
  isHardware,
  user,
  nixpkgs,
  home-manager,
  sops-nix,
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
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowBroken = true;
        allowUnsupportedSystem = true;
      };
      overlays =
        [
          (import ../overlays)
          (import ../packages)
        ]
        ++ extraOverlays;
    };

    extraArgs = {
      inherit pkgs inputs isHardware user secrets dotfiles timezone system stateVersion;
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
            ./configuration.nix
            ./${host}
            sops-nix.nixosModules.sops
            {
              sops = {
                defaultSopsFile = ../secrets/encrypted.yaml;
                # validateSopsFiles = false;
                gnupg.home = "/home/${user}/.gnupg";
                gnupg.sshKeyPaths = [];
              };
            }
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
              };
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
          sops-nix.nixosModules.sops
          {
            sops = {
              defaultSopsFile = ../secrets/encrypted.yaml;
              # validateSopsFiles = false;
              gnupg.home = "/home/${user}/.gnupg";
              gnupg.sshKeyPaths = [];
            };
          }
          ../modules/options.nix
          ./home.nix
          ./${host}/home.nix
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
      name = host;
      value = mkHost mInput isNixOS isHardware;
    })
    permutatedHosts)
