{ ... }:

{
  home.shellAliases = {
    exa = "exa --icons --all --git --binary --group-directories-first";
    ls = "exa";
    l = "exa --classify";
    ll = "exa --long --header";
    c = "clear";

    "_" = "sudo";
    "....." = "cd ../../../..";
    "...." = "cd ../../..";
    "..." = "cd ../..";
    ".." = "cd ..";
    cnc = "grep '^[^#;]'";
    cpuu = "ps -e -o pcpu,cpu,nice,state,cputime,args --sort pcpu | sed '/^ 0.0 /d'";
    dud = "du -h --max-depth=1 --one-file-system";
    dudg = "du -h --max-depth=1 --one-file-system 2>&1 | egrep '^[0-9.]*G'";
    grep = "grep --color --exclude-dir='.svn' --exclude-dir='.git'";
    hc = "history | cut -b 8-";
    # l = "ls -lF";
    la = "ls -lAF";
    # ll = "ls -la --color=tty";
    lsd = "ls -lF | grep --color=never '^d'";
    h = "history";
    hg = "history | grep --colour=auto";
    "l." = "ls -d .[a-zA-Z]* --color=tty";
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
}
