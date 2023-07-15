{
  description = "Mike's system configuration";

  inputs = {

    # Used for system packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Used for MacOS system config
    darwin.url = "github:/lnl7/nix-darwin/master";

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
      supportedSystems = [ "x86_64-linux" "aarch64-darwin" ];

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
        let pkgs = import nixpkgs { inherit system overlays; };
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
              alias nrh="statix check && nix fmt && rm ~/.config/mimeapps.list; home-manager switch --flake .#xps15"
              alias nrt="statix check && nix fmt && sudo nixos-rebuild test --flake path:.#xps15"
              alias nrb="statix check && nix fmt && nix flake update && git add . && nixos-rebuild build --flake path:.#xps15"
              alias nrs="statix check && nix fmt && rm ~/.config/mimeapps.list; sudo nixos-rebuild switch --flake path:.#xps15 && git add . && git commit";
              alias nru="statix check && nix fmt && rm ~/.config/mimeapps.list; sudo nixos-rebuild switch --flake path:.#xps15 --upgrade && git add . && git commit";
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
      };

    };

}
