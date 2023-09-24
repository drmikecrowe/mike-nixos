{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./applications
    ./neovim
    ./programming
    ./shell
    ./user-services
  ];

  options = {
    user = lib.mkOption {
      type = lib.types.str;
      description = "Primary user of the system";
    };
    fullName = lib.mkOption {
      type = lib.types.str;
      description = "Human readable name of the user";
    };
    userDirs = {
      # Required to prevent infinite recursion when referenced by himalaya
      download = lib.mkOption {
        type = lib.types.str;
        description = "XDG directory for downloads";
        default = "$HOME/Downloads";
      };
    };
    identityFile = lib.mkOption {
      type = lib.types.str;
      description = "Path to existing private key file.";
      default = "/etc/ssh/ssh_host_ed25519_key";
    };
    gui = {
      enable = lib.mkEnableOption {
        description = "Enable graphics.";
        default = false;
      };
    };
    theme = {
      colors = lib.mkOption {
        type = lib.types.attrs;
        description = "Base16 color scheme.";
        default = (import ../colorscheme/gruvbox).dark;
      };
      dark = lib.mkOption {
        type = lib.types.bool;
        description = "Enable dark mode.";
        default = true;
      };
    };
    homePath = lib.mkOption {
      type = lib.types.str;
      description = "Path of user's home directory.";
      default =
        if pkgs.stdenv.isDarwin
        then "/Users/${config.user}"
        else "/home/${config.user}";
    };
    dotfilesPath = lib.mkOption {
      type = lib.types.str;
      description = "Path of dotfiles repository.";
      default = lib.concatStrings [config.homePath "/Programming/Personal/nix-os/mike-nixos"];
    };
    dotfilesRepo = lib.mkOption {
      type = lib.types.str;
      description = "Link to dotfiles repository.";
    };
  };

  config = let
    stateVersion = "23.05";
  in {
    nix = {
      # Enable features in Nix commands
      extraOptions = ''
        experimental-features = nix-command flakes
        warn-dirty = false
      '';

      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
      };

      settings = {
        # Add community Cachix to binary cache
        # Don't use with macOS because blocked by corporate firewall
        builders-use-substitutes = true;
        substituters =
          lib.mkIf (!pkgs.stdenv.isDarwin)
          ["https://nix-community.cachix.org"];
        trusted-public-keys = lib.mkIf (!pkgs.stdenv.isDarwin) [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];

        # Scans and hard links identical files in the store
        # Not working with macOS: https://github.com/NixOS/nix/issues/7273
        auto-optimise-store = lib.mkIf (!pkgs.stdenv.isDarwin) true;
      };
    };

    environment.localBinInPath = true;

    # Use the system-level nixpkgs instead of Home Manager's
    home-manager.useGlobalPkgs = true;

    # Install packages to /etc/profiles instead of ~/.nix-profile, useful when
    # using multiple profiles for one user
    home-manager.useUserPackages = true;

    # Pin a state version to prevent warnings
    home-manager.users.${config.user}.home.stateVersion = stateVersion;
    home-manager.users.root.home.stateVersion = stateVersion;
  };
}
