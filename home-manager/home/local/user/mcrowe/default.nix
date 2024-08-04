{
  inputs,
  pkgs,
  dotfiles,
  ...
}: {
  imports = [
    ./aliases.nix
    ./git.nix
    ./gtk.nix
    ./scripts.nix
  ];

  config = {
    home = {
      packages = with pkgs; [
        inputs.devenv.packages.${system}.devenv
        bcompare
        betterbird
        copyq
        corepack
        dbeaver-bin
        dconf2nix
        element-desktop
        flameshot
        gimp
        glxinfo
        hifile
        jetbrains.idea-ultimate
        jetbrains.jdk
        # kupfer
        albert
        libreoffice
        libsForQt5.kgpg
        meld
        nodejs_20
        obsidian
        peek
        qcad
        sqlcmd
        teams-for-linux
        warp-terminal
        wavebox
        yubikey-manager
        yubikey-personalization-gui
        yubioath-flutter
        zoom-us
      ];
      file = {
        ".rgignore".text = builtins.readFile "${dotfiles}/ignore.txt";
        ".fdignore".text = builtins.readFile "${dotfiles}/ignore.txt";
        ".digrc".text = "+noall +answer"; # Cleaner dig commands
      };
    };
  };
}
