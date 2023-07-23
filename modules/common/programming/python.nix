{ config, pkgs, lib, ... }: {

  options.python.enable = lib.mkEnableOption "Python programming language.";

  config = lib.mkIf config.python.enable {

    home-manager.users.${config.user} = {

      home.packages = with pkgs; [
        # python310 # Standard Python interpreter
        nodePackages.pyright # Python language server
        black # Python formatter
        python310Packages.flake8 # Python linter
        python310Packages.mypy # Python linter
      ];

      programs.fish.shellAbbrs = { py = "python3"; };

    };

  };

}
