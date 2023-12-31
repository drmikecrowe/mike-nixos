{
  description = "Mike's system configuration";

  nixConfig.extra-substituters = [
    "https://nix-community.cachix.org"
    "https://nixpkgs-update.cachix.org"
    "https://mic92.cachix.org"
  ];
  nixConfig.extra-trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "nixpkgs-update.cachix.org-1:6y6Z2JdoL3APdu6/+Iy8eZX2ajf09e4EE9SnxSML1W8="
    "mic92.cachix.org-1:gi8IhgiT3CYZnJsaW7fxznzTkMUOn1RY4GmXdT/nXYQ="
  ];

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-hardware.url = "github:drmikecrowe/nixos-hardware";
    # nixos-hardware.url = "github:NixOS/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence/master";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    wallpapers = {
      url = "gitlab:exorcist365/wallpapers";
      flake = false;
    };
    hosts = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , home-manager
    , nixos-hardware
    , impermanence
    , ...
    }:
    let
      user = "mcrowe";

      dotfiles = ./dotfiles;

      linuxSystem = "x86_64-linux";

      hosts = [
        {
          host = "xps15";
          extraOverlays = [ ];
          extraModules = [ ];
          timezone = "America/New_York";
          stateVersion = "22.05";
        }
      ];

      systems = [
        { system = linuxSystem; }
      ];

      forAllSystems = nixpkgs.lib.genAttrs [ linuxSystem ];

      commonInherits = {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager;
        inherit user dotfiles hosts systems;
      };
    in
    {
      nixosConfigurations = import ./hosts (commonInherits
        // {
        isNixOS = true;
        isHardware = true;
      });

      homeConfigurations = import ./hosts (commonInherits
        // {
        isNixOS = false;
        isHardware = false;
      });

      formatter.${linuxSystem} = nixpkgs.legacyPackages.${linuxSystem}.nixpkgs-fmt;

      # Development environments
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            name = "flakeShell";
            buildInputs = with pkgs; [
              git
              git-crypt
              stylua
              nixfmt
              shfmt
              shellcheck
              statix
              nvd
              nix-prefetch-scripts
              ssh-to-age
            ];
          };
        });

      templates = rec {
        default = basic;
        basic = {
          path = ./templates/basic;
          description = "Basic program template";
        };
        poetry = {
          path = ./templates/poetry;
          description = "Poetry template";
        };
        python = {
          path = ./templates/python;
          description = "Legacy Python template";
        };
        typescript = {
          path = ./templates/typescript;
          description = "Typescript template";
        };
      };
    };
}
