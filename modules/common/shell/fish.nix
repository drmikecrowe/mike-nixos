{ config, pkgs, lib, ... }: {

  users.users.${config.user}.shell = pkgs.fish;
  programs.fish.enable =
    true; # Needed for LightDM to remember username (TODO: fix)

  home-manager.users.${config.user} = {

    # Packages used in abbreviations and aliases
    home.packages = with pkgs; [
      curl
      exa
      grc
      fishPlugins.colored-man-pages
      fishPlugins.grc
      fishPlugins.plugin-git
    ];

    home.sessionVariables.fish_greeting = "";

    programs.starship.enableFishIntegration = true;
    programs.zoxide.enableFishIntegration = true;
    programs.fzf.enableFishIntegration = true;

    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        fish_vi_key_bindings
        bind yy fish_clipboard_copy
        bind Y fish_clipboard_copy
        bind -M visual y fish_clipboard_copy
        bind -M default p fish_clipboard_paste
        set -g fish_vi_force_cursor
        set -g fish_cursor_default block
        set -g fish_cursor_insert line
        set -g fish_cursor_visual block
        set -g fish_cursor_replace_one underscore
      '';
      loginShellInit = "";

      shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        "l." = "ls -d .[a-zA-Z]* --color=tty";
        bash = "${pkgs.bashInteractive}/bin/bash";
        c = "clear";
        cnc = "grep '^[^#;]'";
        cpuu =
          "ps -e -o pcpu,cpu,nice,state,cputime,args --sort pcpu | sed '/^ 0.0 /d'";
        dud = "du -h --max-depth=1 --one-file-system";
        dudg = "du -h --max-depth=1 --one-file-system 2>&1 | egrep '^[0-9.]*G'";
        exa = "exa --icons --all --git --binary --group-directories-first";
        grep = "grep --color --exclude-dir='.svn' --exclude-dir='.git'";
        h = "history";
        hc = "history | cut -b 8-";
        hg = "history | grep --colour=auto";
        l = "exa --classify";
        la = "ls -lAF";
        ll = "exa --long --header";
        ls = "exa";
        lsd = "ls -lF | grep --color=never '^d'";
        md = "mkdir -p";
        nixdevnode =
          "nix flake init -t github:akirak/flake-templates#node-typescript";
        psa = "ps aux | cut -b -180";
        psag = "ps aux | cut -b -180 | grep";
        psi = "ps h -eo pmem,comm | sort -nr | head";
        rd = "rmdir";
        ssh-ports-open =
          "nmap -T4 -F 192.168.0.10-254 --min-parallelism=20 -oG - | grep 22/open";
        ta = "tmux attach -t";
        tkill = "tmux kill-session -t";
        tls = "tmux ls";
        tnew = "tmux new -s";
        trash = lib.mkIf pkgs.stdenv.isLinux "${pkgs.trash-cli}/bin/trash-put";
        vbpf = "vim ~/.bash_profile";
        vbrc = "vim ~/.bashrc";
      };
      shellInit = "";

    };

    xdg.desktopEntries = lib.mkIf config.gui.enable {
      "kitty-fish" = {
        name = "Fish (kitty)";
        genericName = "Terminal emulator";
        exec = "kitty fish -li";
        icon = "fish";
        categories = [ "System" "TerminalEmulator" "Utility" ];
        type = "Application";
        terminal = false;
      };
    };
  };

}
