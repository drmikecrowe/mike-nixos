{ config, ... }: {
  programs.fzf.enable = true;

  programs.fish = {
    functions = {
      projects = {
        description = "Jump to a project";
        body = ''
          set projdir ( \
              fd \
                  --search-path $HOME/dev \
                  --type directory \
                  --exact-depth 2 \
              | sed 's/\\/$//' \
              | fzf \
                  --delimiter '/' \
                  --with-nth 6.. \
          )
          and cd $projdir
          and commandline -f execute
        '';
      };
    };
    shellAbbrs = { lsf = "ls -lh | fzf"; };
  };

  # Global fzf configuration
  home.sessionVariables =
    let
      fzfCommand = "fd --type file";
    in
    {
      FZF_DEFAULT_COMMAND = fzfCommand;
      FZF_CTRL_T_COMMAND = fzfCommand;
      FZF_DEFAULT_OPTS = "-m --height 50% --border";
    };
}
