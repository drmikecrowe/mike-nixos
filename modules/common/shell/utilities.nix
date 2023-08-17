{ config, pkgs, ... }:

let

  ignorePatterns = ''
    !*.tfvars
    !.env*
    !.github/
    !.gitignore
    "*.swp"
    ".DS_Store"
    ".cache/"
    ".direnv/"
    ".history"
    ".idea/"
    ".venv"
    ".vscode/"
    "npm-debug.log"
    .target/
    .terraform/
    /Library/
  '';

in
{

  config = {

    home-manager.users.${config.user} = {

      home.packages = with pkgs; [
        age # Encryption
        awscli2
        aws-sso-cli
        atuin
        bat
        bc # Calculator
        dig # DNS lookup
        fd # find
        gnumake
        home-manager
        htop # Show system processes
        inetutils # Includes telnet, whois
        jq # JSON manipulation
        mc
        nmap
        ripgrep # grep
        rsync # Copy folders
        sd # sed
        tealdeer # Cheatsheets
        tree # View directory hierarchy
        unzip # Extract zips
        vimv-rs # Batch rename files
        # chatgpt
        shell_gpt
        chatblade
      ];

      programs.zoxide.enable = true; # Shortcut jump command

      home.file = {
        ".rgignore".text = ignorePatterns;
        ".fdignore".text = ignorePatterns;
        ".digrc".text = "+noall +answer"; # Cleaner dig commands
      };

      programs.bat = {
        enable = true; # cat replacement
        config = {
          theme = config.theme.colors.batTheme;
          pager = "less -R"; # Don't auto-exit if one screen
        };
      };

      programs.fish.functions = {
        ping = {
          description = "Improved ping";
          argumentNames = "target";
          body = "${pkgs.prettyping}/bin/prettyping --nolegend $target";
        };
      };

    };

  };

}
