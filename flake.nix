{
  description = "Mike's system configuration";

  inputs = {
    # Used for system packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Used for MacOS system config
    # darwin.url = "github:/lnl7/nix-darwin/master";

    # Wallpapers
    wallpapers = {
      url = "gitlab:exorcist365/wallpapers";
      flake = false;
    };

    # Used for user packages and dotfiles
    home-manager.url = "github:nix-community/home-manager/master";

    # Used to generate NixOS images for other platforms
    nixos-generators.url = "github:nix-community/nixos-generators";

    nixos-hardware.url = "github:drmikecrowe/nixos-hardware";

    # Convert Nix to Neovim config
    nix2vim.url = "github:gytis-ivaskevicius/nix2vim";

    nixos-impermanence.url = "github:nix-community/impermanence";

  };

  outputs = { nixpkgs, home-manager, ... }@inputs:

    let

      system = "x86_64-linux";

      globals = rec {
        user = "mcrowe";
        fullName = "Mike Crowe";
      };

      # Common overlays to always use
      overlays = [
        # (import ./overlays/neovim-p/lugins.nix inputs)
        inputs.nix2vim.overlay
        (final: prev: {
          openssh = prev.openssh.overrideAttrs (old: {
            patches = (old.patches or [ ]) ++ [ ./patches/openssh.patch ];
            doCheck = false;
          });
        })
      ];

      pkgs = import nixpkgs
        {
          system = "${system}";
          config.allowUnfree = true;
          config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
            "samsung-UnifiedLinuxDriver"
          ];
        };

      # System types to support.
      supportedSystems = [ system ]; #  "aarch64-darwin"

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    in
    rec {

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        xps15 = import ./hosts/xps15 { inherit inputs globals overlays; };
      };

      # Contains my full Mac system builds, including home-manager
      # darwin-rebuild switch --flake .#lookingglass
      # darwinConfigurations = {
      #   lookingglass =
      #     import ./hosts/lookingglass { inherit inputs globals overlays; };
      # };

      homeConfigurations = {
        "${globals.user}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
          # > Our main home-manager configuration file <
          modules = [ nixosConfigurations.xps15.config.home-manager.users.${globals.user}.home ];
        };
        # xps15 = nixosConfigurations.xps15.config.home-manager.users.${globals.user}.home; 
      };

      packages =
        let
          staff = system:
            import ./hosts/staff { inherit inputs globals overlays system; };
        in
        { x86_64-linux.default = staff "x86_64-linux"; };

      formatter = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in pkgs.nixpkgs-fmt);

      # Programs that can be run by calling this flake
      apps = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system overlays; };
        in import ./apps { inherit pkgs; });

      # Development environments
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system overlays; };
          PRE_CMDS = "statix check && nix fmt && git add --intent-to-add .";
        in
        {
          default = pkgs.mkShell {
            name = "flakeShell";
            buildInputs = with pkgs; [
              git
              stylua
              nixfmt
              shfmt
              shellcheck
              statix
            ];
            shellHook = ''
              alias nrh="${PRE_CMDS}; home-manager switch --impure"
              alias nrs="${PRE_CMDS}; sudo sh -c \"NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch --impure\""
            '';
          };

        });

      # Templates for starting other projects quickly
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
