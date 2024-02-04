{ config
, dotfiles
, pkgs
, stateVersion
, user
, ...
}: {
  imports = [
    ../modules/home
    ./my-home-packages.nix
  ];

  home.file = {
    ".rgignore".text = builtins.readFile "${dotfiles}/ignore.txt";
    ".fdignore".text = builtins.readFile "${dotfiles}/ignore.txt";
    ".digrc".text = "+noall +answer"; # Cleaner dig commands
  };

  programs = {
    atuin = {
      enable = true;
      enableNushellIntegration = true;
      enableFishIntegration = true;
      package = pkgs.atuin;
      flags = [ "--disable-up-arrow" ];
    };
    bat = {
      enable = true; # cat replacement
      config = {
        # theme = config.theme.colors.batTheme;
        pager = "less -R"; # Don't auto-exit if one screen
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    tmux = {
      enable = true;
      clock24 = true;
    };
    zoxide.enable = true; # Shortcut jump command
  };

  services.pass-secret-service = {
    package = pkgs.libsecret;
    enable = true;
  };


  home.stateVersion = stateVersion;
}
