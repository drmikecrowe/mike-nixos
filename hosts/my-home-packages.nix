{pkgs, ...}: {
  home.packages = with pkgs; [
    # chatgpt
    alejandra
    argc
    argc-completions
    aws-sso-cli
    awscli2
    bc # Calculator
    chatblade
    deno
    dig # DNS lookup
    dua
    eza
    fd # find
    fish
    git-crypt
    gitlab-runner
    glab # gitlab cli
    gnumake
    home-manager
    htmlq
    htop # Show system processes
    inetutils # Includes telnet, whois
    jq # JSON manipulation
    mc
    nil # Nix language server
    nixfmt # Nix file formatter
    nmap
    nnn
    nushell
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
    xplr
    yq-go
  ];
}
