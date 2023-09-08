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

    # Used for Windows Subsystem for Linux compatibility
    wsl.url = "github:nix-community/NixOS-WSL";

    # Used for user packages and dotfiles
    home-manager.url = "github:nix-community/home-manager/master";

    # Used to generate NixOS images for other platforms
    nixos-generators.url = "github:nix-community/nixos-generators";

    nixos-hardware.url = "github:drmikecrowe/nixos-hardware";

    # Convert Nix to Neovim config
    nix2vim.url = "github:gytis-ivaskevicius/nix2vim";

    nixos-impermanence.url = "github:nix-community/impermanence";

  };

  outputs = { nixpkgs, ... }@inputs:

    let

      globals = rec {
        user = "mcrowe";
        fullName = "Mike Crowe";
        # gitName = fullName;
        # gitEmail = "drmikecrowe@gmail.com";
      };

      # Common overlays to always use
      overlays = [
        # (import ./overlays/neovim-p/lugins.nix inputs)
        inputs.nix2vim.overlay
      ];

      # System types to support.
      supportedSystems = [ "x86_64-linux" ]; #  "aarch64-darwin"

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

      # For quickly applying local settings with:
      # home-manager switch --flake .#xps15
      homeConfigurations = {
        xps15 =
          nixosConfigurations.xps15.config.home-manager.users.${globals.user}.home;
        # lookingglass =
        #   darwinConfigurations.lookingglass.config.home-manager.users."Noah.Masur".home;
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
          PRE_CMDS = "statix check && nix fmt && git add .";
          FLAKE = "--flake .#xps15 --impure";
          COMMIT = "git diff | sgpt 'Generate git commit message, for my changes' > /tmp/gitmsg && git add . && git commit -F /tmp/gitmsg";
        in
        {

          # Used to run commands and edit files in this repo
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
              alias nrh="${PRE_CMDS}; home-manager switch -b backup ${FLAKE} && ${COMMIT}"
              alias nrt="${PRE_CMDS}; sudo sh -c \"NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild test ${FLAKE}\""
              alias nrb="${PRE_CMDS}; nix flake update && nixos-rebuild build ${FLAKE}"
              alias nrs="${PRE_CMDS}; sudo sh -c \"NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch ${FLAKE}\" && ${COMMIT}"
              alias nru="${PRE_CMDS}; nix flake update && nixos-rebuild build ${FLAKE}"
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
