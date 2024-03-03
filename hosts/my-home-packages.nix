{pkgs, ...}: {
  home.packages = with pkgs; [
    # chatgpt
    alejandra
    argc
    argc-completions
    atool
    aws-sso-cli
    awscli2
    bc # Calculator
    chatblade
    deno
    dig # DNS lookup
    dua
    eza
    fd # find
    git-crypt
    gitlab-runner
    glab # gitlab cli
    glow # markdown preview cli
    gnumake
    htmlq
    htop # Show system processes
    inetutils # Includes telnet, whois
    jq # JSON manipulation
    lunarvim
    mc
    miller # csv from the cli
    nil # Nix language server
    nixd
    nmap
    nushell
    ouch
    ripgrep # grep
    rsync # Copy folders
    sd # sed
    shell_gpt
    tealdeer # Cheatsheets
    tree # View directory hierarchy
    unzip # Extract zips
    vifm
    vimv-rs # Batch rename files
    xonsh
    yq-go
  ];
}