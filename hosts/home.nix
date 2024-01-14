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
    alejandra
    dua
    dig # DNS lookup
    fd # find
    fish
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
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableFishIntegration = true;
      package = pkgs.atuin;
      flags = [ "--disable-up-arrow" ];
    };
    zoxide = {
      enable = true; # Shortcut jump command
    };
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
    fish.enable =
      true; # Needed for LightDM to remember username (TODO: fix)
    fish.functions = {
      ping = {
        description = "Improved ping";
        argumentNames = "target";
        body = "${pkgs.prettyping}/bin/prettyping --nolegend $target";
      };
    };
    nushell = {
      enable = true;
      extraConfig = builtins.readFile "${dotfiles}/atuin/init.nu";
    };
    bash = {
      enable = true;
      historyControl = [ "ignoredups" "ignorespace" ];
    };
    starship = {
      enableBashIntegration = true;
    };
    zoxide = {
      enableBashIntegration = true;
    };
    fzf = {
      enableBashIntegration = true;
    };
  };

  home.stateVersion = stateVersion;
}
