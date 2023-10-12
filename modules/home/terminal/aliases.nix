{ config
, pkgs
, lib
, options
, ...
}: {
  home.shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    "l." = "ls -d .[a-zA-Z]* --color=tty";
    bash = "${pkgs.bashInteractive}/bin/bash";
    c = "clear";
    cnc = "grep '^[^#;]'";
    code = "flatpack run com.visualstudio.code --wait";
    cpuu = "ps -e -o pcpu,cpu,nice,state,cputime,args --sort pcpu | sed '/^ 0.0 /d'";
    dud = "du -h --max-depth=1 --one-file-system";
    dudg = "du -h --max-depth=1 --one-file-system 2>&1 | egrep '^[0-9.]*G'";
    eza = "eza --icons --all --git --binary --group-directories-first";
    grep = "grep --color --exclude-dir='.svn' --exclude-dir='.git'";
    h = "history";
    hc = "history | cut -b 8-";
    hg = "history | grep --colour=auto";
    l = "eza -l --classify";
    la = "ls -lAF";
    ll = "eza --long --header";
    ls = "eza --classify";
    lsd = "ls -lF | grep --color=never '^d'";
    md = "mkdir -p";
    nixdevnode = "nix flake init --refresh --template github:drmikecrowe/mike-nixos#typescript";
    nixdevpoetry = "nix flake init --refresh --template github:drmikecrowe/mike-nixos#poetry";
    nixdevpython = "nix flake init --refresh --template github:drmikecrowe/mike-nixos#python";
    psa = "ps aux | cut -b -180";
    psag = "ps aux | cut -b -180 | grep";
    psi = "ps h -eo pmem,comm | sort -nr | head";
    rd = "rmdir";
    ssh-ports-open = "nmap -T4 -F 192.168.0.10-254 --min-parallelism=20 -oG - | grep 22/open";
    ta = "tmux attach -t";
    tkill = "tmux kill-session -t";
    tls = "tmux ls";
    tnew = "tmux new -s";
    trash = lib.mkIf pkgs.stdenv.isLinux "${pkgs.trash-cli}/bin/trash-put";
    vbpf = "vim ~/.bash_profile";
    vbrc = "vim ~/.bashrc";
  };
  home.shellAliases = lib.mkIf config.gui.enable {
    pbcopy = "xclip -selection clipboard -in";
    pbpaste = "xclip -selection clipboard -out";
  };
}
