{
  config,
  inputs,
  lib,
  pkgs,
  specialArgs,
  ...
}: let
  if-exists = f: builtins.pathExists f;
  existing-imports = imports: builtins.filter if-exists imports;
  inherit (specialArgs) role username desktopEnvironment;
in {
  config = {
    host = {
      home = {
        users = {
          enabled = [username];
        };
        applications = {
          atuin.enable = lib.mkDefault true;
          aws-sso-cli.enable = lib.mkDefault true;
          bash.enable = lib.mkDefault true;
          direnv.enable = lib.mkDefault true;
          fish.enable = lib.mkDefault true;
          git.enable = lib.mkDefault true;
          github.enable = lib.mkDefault true;
          gnupg.enable = lib.mkDefault true;
          neovim.enable = lib.mkDefault true;
          starship.enable = lib.mkDefault true;
          tmux.enable = lib.mkDefault true;
          vscode.enable = lib.mkDefault true;
          wezterm.enable = lib.mkDefault true;
          yazi.enable = lib.mkDefault true;
          zoxide.enable = lib.mkDefault true;
          zsh.enable = lib.mkDefault true;
        };
        feature = {
        };
      };
    };
    home = {
      packages = with pkgs; [
        alejandra
        atool
        awscli2
        bc
        chatblade
        codeium
        copyq
        dconf2nix
        dig
        dua
        element-desktop
        eza
        fd
        flameshot
        gimp
        git-crypt
        gitlab-runner
        glab
        glow
        glxinfo
        hifile
        htmlq
        htop
        hunspell
        hunspellDicts.en_US
        imagemagick
        inetutils
        jq
        libreoffice
        mc
        meld
        miller
        nixd
        nmap
        nushell
        obsidian
        onefetch
        ouch
        peek
        psmisc
        ripgrep
        rsync
        sd
        strace
        tealdeer
        teams-for-linux
        tree
        unzip
        wavebox
        xdg-utils
        yq-go
        yubikey-manager
        yubikey-personalization-gui
        yubioath-flutter
        zoom-us
      ];
    };
  };
  imports =
    [
      ./home-manager.nix
      ./locale.nix
      ./nix.nix
    ]
    ++ existing-imports [
      ./role/${role}
      ./role/${role}.nix
    ];
}
