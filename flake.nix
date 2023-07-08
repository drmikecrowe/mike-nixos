{
  description = "Mike's system configuration";

  inputs = {
    # Unstable Branch
    # nixpkgs.url = "nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "nixpkgs/master";
    # flake-parts.url = "github:hercules-ci/flake-parts";

    # Stable Branch
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware-test.url = "github:drmikecrowe/nixos-hardware/ddda5263a22ce865e92c5a0450ee9efa1905f5f2";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs-unstable, home-manager, nixos-hardware-test, ... }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs-unstable.lib.genAttrs [
        # "aarch64-linux"
        # "i686-linux"
        "x86_64-linux"
        # "aarch64-darwin"
        # "x86_64-darwin"
      ];

    in
    rec {
      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system:
        let pkgs = nixpkgs-unstable.legacyPackages.${system};
        in { default = import ./pkgs { inherit pkgs; }; }
      );
      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs-unstable.legacyPackages.${system};
        in { default = import ./shell.nix { inherit pkgs; }; }
      );

      formatter = forAllSystems (system:
        let pkgs = nixpkgs-unstable.legacyPackages.${system};
        in pkgs.nixpkgs-fmt);

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        xps15 = nixpkgs-unstable.lib.nixosSystem {
          specialArgs = { inherit inputs outputs self; }; # Pass flake inputs to our config
          system = "x86_64-linux";
          modules = [
            # > Our main nixos configuration file <
            ./hosts/xps15/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = { inherit inputs outputs; };
                users = {
                  mcrowe = import ./home-manager;
                };
              };
            }
          ];
        };
      };
    };

}



# {
#   description = "Home Manager configuration of mcrowe";

#   inputs = {
#     # Specify the source of Home Manager and Nixpkgs.
#     nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
#     home-manager = {
#       url = "github:nix-community/home-manager";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#   };

#   outputs = { nixpkgs, home-manager, ... }:
#     let
#       system = "x86_64-linux";
#       pkgs = nixpkgs.legacyPackages.${system};
#     in {
#       homeConfigurations."mcrowe" = home-manager.lib.homeManagerConfiguration {
#         inherit pkgs;

#         # Specify your home configuration modules here, for example,
#         # the path to your home.nix.
#         modules = [ ./home.nix ];

#         # Optionally use extraSpecialArgs
#         # to pass through arguments to home.nix
#       };
#     };
# }
