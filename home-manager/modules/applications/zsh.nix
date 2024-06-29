{
  config,
  lib,
  ...
}: let
  cfg = config.host.home.applications.zsh;
in {
  options = {
    host.home.applications.zsh = {
      enable = lib.mkOption {
        default = true;
        type = lib.types.bool;
        description = "Enables zsh";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "sorin";
        plugins = [
          "git"
          "sudo"
          "1password"
          "aws"
          "direnv"
          "poetry"
          "pipenv"
          "zoxide"
          # more coming
        ];
      };
    };
  };
}
