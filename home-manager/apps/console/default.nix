{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
    ./apps/atuin.nix
    ./apps/carapace.nix
    ./apps/git.nix
    ./apps/nushell.nix
    ./apps/ssh.nix
    #./apps/starship.nix
    ./apps/tmux.nix
    ./apps/utils.nix
  ];

  home = {
    packages = with pkgs; [
      acpi
      atuin
      autojump
      exa
      ffmpeg
      killall
      libnotify
      neofetch
      nix-prefetch-github
      ripgrep
      rustscan
      sshfs
      starship
      unzip
      yubikey-manager
    ];

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "l." = "ls -d .[a-zA-Z]* --color=tty";
      c = "clear";
      cnc = "grep '^[^#;]'";
      cpuu = "ps -e -o pcpu,cpu,nice,state,cputime,args --sort pcpu | sed '/^ 0.0 /d'";
      dud = "du -h --max-depth=1 --one-file-system";
      dudg = "du -h --max-depth=1 --one-file-system 2>&1 | egrep '^[0-9.]*G'";
      nixdevnode = "nix flake init -t github:akirak/flake-templates#node-typescript";
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
      pbcopy = "xclip -selection clipboard";
      psa = "ps aux | cut -b -180";
      psag = "ps aux | cut -b -180 | grep";
      psi = "ps h -eo pmem,comm | sort -nr | head";
      rd = "rmdir";
      ssh-ports-open = "nmap -T4 -F 192.168.0.10-254 --min-parallelism=20 -oG - | grep 22/open";
      ta = "tmux attach -t";
      tkill = "tmux kill-session -t";
      tls = "tmux ls";
      tnew = "tmux new -s";
      vbpf = "vim ~/.bash_profile";
      vbrc = "vim ~/.bashrc";
    };
  };

  programs = {
    autojump.enable = false;
    bash.enable = true;
    fish.enable = true;
    bat.enable = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    fzf.enable = true;
    htop.enable = true;
    jq.enable = true;
    neovim.enable = true;
    zoxide.enable = true;
  };
}
