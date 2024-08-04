{
  description = "drmikecrowe's system configuration";

  outputs = inputs @ {
    self,
    flake-utils,
    nixpkgs,
    home-manager,
    nixos-hardware,
    nur,
    ...
  }: let
    inherit (self) outputs;
    stateVersion = "23.11"; # do not change
    mikeHome = {
      org = "local";
      role = "hybrid";
      hostname = "xps15";
      username = "mcrowe";
      desktop = "gnome";
    };
    extraArgs =
      mikeHome
      // {
        inherit nur;
      };

    forAllSystems = nixpkgs.lib.genAttrs flake-utils.lib.defaultSystems;
    libx = import ./lib {inherit inputs outputs stateVersion nixos-hardware home-manager;};
  in {
    packages = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./pkgs {inherit inputs pkgs;}
    );

    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./shell.nix {inherit pkgs;}
    );

    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules;

    homeConfigurations = {
      "mcrowe_xps15" = libx.mkHome extraArgs;
    };

    nixosConfigurations = {
      xps15 = libx.mkHost extraArgs;
    };

    templates = rec {
      default = basic;
      basic = {
        path = ./templates/basic;
        description = "Basic program template";
      };
      python = {
        path = ./templates/python;
        description = "Legacy Python template";
      };
      poetry = {
        path = ./templates/poetry;
        description = "Poetry template";
      };
      typescript = {
        path = ./templates/typescript;
        description = "Typescript template";
      };
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://numtide.cachix.org"
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://nixpkgs-update.cachix.org"
      "https://devenv.cachix.org"
      "https://xonsh-xontribs.cachix.org"
    ];
    extra-trusted-public-keys = [
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-update.cachix.org-1:6y6Z2JdoL3APdu6/+Iy8eZX2ajf09e4EE9SnxSML1W8="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "xonsh-xontribs.cachix.org-1:LgP0Eb1miAJqjjhDvNafSrzBQ1HEtfNl39kKtgF5LBQ="
    ];
  };

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flatpaks.url = "github:GermanBread/declarative-flatpak/stable";
    nixpkgs = {
      url = "github:numtide/nixpkgs-unfree";
      follows = "nixpkgs-unstable";
    };
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    comma.url = "github:nix-community/comma";
    home-manager.url = "github:nix-community/home-manager/master";
    nixos-generators.url = "github:nix-community/nixos-generators";
    # nixos-hardware.url = "github:drmikecrowe/nixos-hardware";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    # impermanence.url = "github:nix-community/impermanence/master";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    devenv.url = "github:cachix/devenv/latest";
    wallpapers = {
      url = "gitlab:exorcist365/wallpapers";
      flake = false;
    };
    impermanence.url = "github:nix-community/impermanence/master";
    nur.url = "github:nix-community/NUR";
    nix-colors.url = "github:misterio77/nix-colors";
    parts.url = "github:hercules-ci/flake-parts";
    hosts = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nix-snapd.url = "github:io12/nix-snapd";
    # nix-snapd.inputs.nixpkgs.follows = "nixpkgs";
  };
}
