{
  config,
  dotfiles,
  pkgs,
  stateVersion,
  user,
  ...
}: {
  programs = {
    bash.initExtra = ''
      if [[ $TERM != "dumb" ]]; then
        source ${pkgs.argc-completions}/bin/argc-completions.bash
      fi
    '';

    fish.interactiveShellInit = ''
      if test "$TERM" != "dumb"
        source ${pkgs.argc-completions}/bin/argc-completions.fish
      end
    '';

    zsh.initExtra = ''
      if [[ $TERM != "dumb" ]]; then
        source ${pkgs.argc-completions}/bin/argc-completions.zsh
      fi
    '';

    nushell.extraConfig = ''
      source ${pkgs.argc-completions}/bin/argc-completions.nu
    '';

    atuin = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      package = pkgs.atuin;
      flags = ["--disable-up-arrow"];
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
      # enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
    fzf = {
      # Config at modules/home/terminal/fzf.nix
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    # keychain = {
    #   enable = true;
    #   enableBashIntegration = true;
    #   enableFishIntegration = true;
    #   enableNushellIntegration = true;
    #   enableZshIntegration = true;
    # };
    # Provides "command-not-found" options
    nix-index = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    starship = {
      # Config at modules/home/terminal/starship.nix
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
    yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
  };
}
