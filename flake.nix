{
  description = "Mike's system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-hardware.url = "github:drmikecrowe/nixos-hardware";
    # nixos-hardware.url = "github:NixOS/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence/master";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    sops-nix.url = "github:Mic92/sops-nix";
    wallpapers = {
      url = "gitlab:exorcist365/wallpapers";
      flake = false;
    };
    hosts = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    impermanence,
    sops-nix,
    ...
  }: let
    user = "mcrowe";

    secrets = import ./secrets {
      inherit (nixpkgs) lib;
      inherit sops-nix;
    };

    dotfiles = ./dotfiles;

    linuxSystem = "x86_64-linux";

    hosts = [
      {
        host = "xps15";
        extraOverlays = [];
        extraModules = [];
        timezone = "America/New_York";
        stateVersion = "22.05";
      }
    ];

    systems = [
      {system = linuxSystem;}
    ];

    forAllSystems = nixpkgs.lib.genAttrs [linuxSystem];

    commonInherits = {
      inherit (nixpkgs) lib;
      inherit inputs nixpkgs home-manager;
      inherit user secrets dotfiles hosts systems sops-nix;
    };
  in {
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
    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (sops-nix.packages.${system}) sops-init-gpg-key sops-import-keys-hook;
    in {
      default = pkgs.mkShell {
        name = "flakeShell";
        sopsPGPKeyDirs = ["./keys/users/"];
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
          sops-init-gpg-key
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
