{ lib, ... }: {
  options = {
    secrets = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
    physical = lib.mkEnableOption {
      description = "Whether this machine is a physical device.";
      default = false;
    };
    gui = {
      enable = lib.mkEnableOption {
        description = "Whether this machine has the GUI enabled.";
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
        default = (import ../../colorscheme/gruvbox).dark;
      };
      dark = lib.mkOption {
        type = lib.types.bool;
        description = "Enable dark mode.";
        default = true;
      };
    };
  };
}
