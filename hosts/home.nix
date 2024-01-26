{ config
, dotfiles
, pkgs
, stateVersion
, user
, ...
}: {
  imports = [
    ../modules/home
  ];
  home.packages = with pkgs; [
    # chatgpt
    age # Encryption
    alejandra
    argc
    aws-sso-cli
    awscli2
    bc # Calculator
    chatblade
    deno
    dua
    dig # DNS lookup
    fd # find
    fish
    glab # gitlab cli
    gitlab-runner
    git-crypt
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
    nushell
    ripgrep # grep
    rsync # Copy folders
    sd # sed
    shell_gpt
    tealdeer # Cheatsheets
    tree # View directory hierarchy
    unzip # Extract zips
    vimv-rs # Batch rename files
    xplr
    xonsh
  ];

  home.file = {
    ".rgignore".text = builtins.readFile "${dotfiles}/ignore.txt";
    ".fdignore".text = builtins.readFile "${dotfiles}/ignore.txt";
    ".digrc".text = "+noall +answer"; # Cleaner dig commands
  };

  programs = {
    atuin = {
      enable = true;
      enableNushellIntegration = true;
      enableFishIntegration = true;
      package = pkgs.atuin;
      flags = [ "--disable-up-arrow" ];
    };
    zoxide.enable = true; # Shortcut jump command
    bat = {
      enable = true; # cat replacement
      config = {
        # theme = config.theme.colors.batTheme;
        pager = "less -R"; # Don't auto-exit if one screen
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  home.stateVersion = stateVersion;
}
