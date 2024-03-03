{
  config,
  dotfiles,
  pkgs,
  user,
  ...
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
    bat = {
      enable = true; # cat replacement
      config = {
        # theme = config.theme.colors.batTheme;
        pager = "less -R"; # Don't auto-exit if one screen
      };
    };
    tmux = {
      enable = true;
      clock24 = true;
    };
  };
}
