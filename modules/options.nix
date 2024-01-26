{ lib
, pkgs
, user
, ...
}: {
  options = {
    custom = {
      _1password = {
        enable = lib.mkEnableOption {
          description = "Enable 1Password.";
          default = false;
        };
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs._1password-gui.override { polkitPolicyOwners = [ "${user}" ]; };
          defaultText = lib.literalExpression "pkgs._1password-gui";
          example = lib.literalExpression "pkgs._1password-gui";
          description = ''
            The 1Password derivation to use. This can be used to upgrade from the stable release that we keep in nixpkgs to the betas.
          '';
        };
      };
      secrets = lib.mkOption {
        type = lib.types.attrs;
        default = { };
      };
      gui = {
        enable = lib.mkEnableOption {
          description = "Whether this machine has the GUI enabled.";
          default = false;
        };
      };
      kde = {
        enable = lib.mkEnableOption {
          description = "Whether to enable KDE plasma";
          default = false;
        };
      };
      continue = {
        enable = lib.mkEnableOption {
          description = "Build and run the continue server.";
          default = false;
        };
      };
      duplicati = {
        enable = lib.mkEnableOption {
          description = "Enable duplicati backups here";
          default = false;
        };
      };
      discord = {
        enable = lib.mkEnableOption {
          description = "Enable Discord.";
          default = false;
        };
      };
      kitty = {
        enable = lib.mkEnableOption {
          description = "Enable Kitty.";
          default = false;
        };
      };
      obsidian = {
        enable = lib.mkEnableOption {
          description = "Enable Obsidian.";
          default = false;
        };
      };
      slack = {
        enable = lib.mkEnableOption {
          description = "Enable Slack.";
          default = false;
        };
      };
      theme = {
        colors = lib.mkOption {
          type = lib.types.attrs;
          description = "Base16 color scheme.";
          default = (import ../../colorscheme/gruvbox).light;
        };
        dark = lib.mkOption {
          type = lib.types.bool;
          description = "Enable dark mode.";
          default = false;
        };
      };
      vivaldi = {
        enable = lib.mkEnableOption {
          description = "Enable vivaldi.";
          default = false;
        };
      };

    };
  };
}
