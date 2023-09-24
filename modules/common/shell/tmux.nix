{
  config,
  pkgs,
  lib,
  ...
}: {
  home-manager.users.${config.user} = {
    packages = with pkgs; [
      tmux
      (pkgs.writeShellApplication {
        name = "pux";
        runtimeInputs = [pkgs.tmux];
        text = ''
          PRJ="$(zoxide query -i)"
          echo "Launching tmux for $PRJ"
          set -x
          cd "$PRJ" && \
            exec tmux -S "$PRJ".tmux attach
        '';
      })
    ];
  };

  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    # Stop tmux+escape craziness.
    escapeTime = 0;
    # Force tmux to use /tmp for sockets (WSL2 compat)
    secureSocket = false;

    plugins = with pkgs; [
      tmuxPlugins.yank
      tmuxPlugins.copycat
      tmuxPlugins.resurrect
      tmuxPlugins.pain-control
      tmuxPlugins.sensible
    ];

    extraConfig = ''
      bind-key C-d detach-client
      bind-key C-c new-window
      bind-key C-p paste-buffer

      bind R refresh-client

      unbind r
      bind r \
          source-file ~/.tmux.conf \;\
          display 'Reloaded tmux config.'

      setw -g mode-keys vi

      unbind s
      unbind C-s
      bind-key s split-window
      bind-key C-s split-window

      unbind v
      unbind C-v
      bind-key v split-window -h
      bind-key C-v split-window -h

      unbind C-k
      bind C-k send-key C-k

      bind e setw synchronize-panes on
      bind E setw synchronize-panes off

      set -g mouse on

      bind m \
          set -g mode-mouse on \;\
          set -g mouse-resize-pane on \;\
          set -g mouse-select-pane on \;\
          set -g mouse-select-window on \;\
          display 'Mouse: ON'

      bind M \
          set -g mode-mouse off \;\
          set -g mouse-resize-pane off \;\
          set -g mouse-select-pane off \;\
          set -g mouse-select-window off \;\
          display 'Mouse: OFF'

      set -g @continuum-restore 'on'
      set -g @yank_selection 'clipboard'
      set-option -g display-panes-active-colour red
      set-option -g display-panes-colour white
      set-option -g message-style bg=black,fg=red
      set-option -g pane-active-border-style fg=red
      set-option -g pane-border-style fg=brightgreen
      set-option -g status-style bg=brightgreen,fg=white,default
      set-window-option -g clock-mode-colour cyan
      set-window-option -g window-status-current-style fg=white,bg=blue
      set-window-option -g window-status-style fg=brightcyan,bg=default
    '';
  };
}
