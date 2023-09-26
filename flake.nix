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
    nide = {
      url = "github:jluttine/NiDE";
      flake = false;
    };
    wallpapers = {
      url = "gitlab:exorcist365/wallpapers";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    impermanence,
    nixos-hardware,
    nide,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;

    globals = rec {
      user = "mcrowe";
      fullName = "Mike Crowe";
    };

    system = "x86_64-linux";
    supportedSystems = [system]; #  "aarch64-darwin"
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    pkgs =
      import nixpkgs
      {
        system = "${system}";
        config.allowUnfree = true;
      };

    overlays = [
      # (import ./overlays/neovim-p/lugins.nix inputs)
      (final: prev: {
        openssh = prev.openssh.overrideAttrs (old: {
          patches = (old.patches or []) ++ [./patches/openssh.patch];
          doCheck = false;
        });
      })
    ];

    extraSpecialArgs = {
      inherit inputs globals home-manager pkgs overlays;
    };

    specialArgs =
      extraSpecialArgs
      // {
        inherit impermanence nixos-hardware nide;
      };

    buildSystem = modules:
      lib.nixosSystem {
        inherit modules system specialArgs;
      };

    buildHome = modules:
      lib.homeManagerConfiguration {
        inherit modules system extraSpecialArgs;
      };
  in rec {
    # NixOS configuration entrypoint
    nixosConfigurations = {
      #import ./hosts/xps15 { inherit inputs globals overlays home-manager impermanence pkgs; };
      xps15 = buildSystem [./hosts/xps15];
    };

    homeConfigurations = {
      "${globals.user}" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit inputs pkgs;};
        modules = [nixosConfigurations.xps15.config.home-manager.users.${globals.user}.home];
      };
    };

    formatter = nixpkgs.lib.genAttrs supportedSystems (
      system:
        nixpkgs.legacyPackages.${system}.alejandra
    );

    # Development environments
    devShells = forAllSystems (system: {
      inherit pkgs;
      default = pkgs.mkShell {
        name = "flakeShell";
        buildInputs = with pkgs; [git stylua nixfmt shfmt shellcheck statix nvd nix-prefetch-scripts];
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
