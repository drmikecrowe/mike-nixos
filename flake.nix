{
  description = "drmikecrowe's system configuration";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs: let
    inherit (self) outputs;
    stateVersion = "23.11"; # do not change
    defaultSystem = "x86_64-linux";
    systems = [defaultSystem];
    libx = import ./lib {inherit inputs outputs systems stateVersion nixos-hardware home-manager;};
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
        inherit systems;
      };
  in {
    nixosModules = import ./modules;

    homeConfigurations = {
      "mcrowe_xps15" = libx.mkHome extraArgs;
    };

    nixosConfigurations = {
      xps15 = libx.mkHost extraArgs;
    };

    formatter = libx.forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in
      pkgs: pkgs.alejandra);

    # Custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # Devshell for bootstrapping; acessible via 'nix develop' or 'nix-shell' (legacy)
    devShells = libx.forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        name = "flakeShell-${system}";
        buildInputs = with pkgs; [
          git
          git-crypt
          stylua
          alejandra
          shfmt
          shellcheck
          statix
          nvd
          nix-prefetch
          nix-prefetch-scripts
          nix-tree
          nixd
          neovim
          # vscodium-fhs
          # nixd
          ripgrep
          docker-compose-language-service
          dockerfile-language-server-nodejs
          lazygit
          bash-language-server
          nodePackages_latest.vscode-json-languageserver
          nodePackages_latest.prettier
          yaml-language-server

          shellcheck
          shfmt

          vimPlugins.nvim-treesitter.withAllGrammars
          tree-sitter
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

  nixConfig.extra-substituters = [
    "https://numtide.cachix.org"
    "https://cache.nixos.org/"
    "https://nix-community.cachix.org"
    "https://nixpkgs-update.cachix.org"
    "https://devenv.cachix.org"
  ];

  nixConfig.extra-trusted-public-keys = [
    "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "nixpkgs-update.cachix.org-1:6y6Z2JdoL3APdu6/+Iy8eZX2ajf09e4EE9SnxSML1W8="
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
  ];

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flatpaks.url = "github:GermanBread/declarative-flatpak/stable";
    nixpkgs.url = "github:numtide/nixpkgs-unfree";
    nixpkgs.follows = "nixpkgs-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

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
