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
    # ./dconf.nix
    ./scripts.nix
    ./ssh.nix
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
        kupfer
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

    systemd.user.services.mbfc-docker = {
      Unit = {
        Description = "build data for mbfc extension";
      };
      Service = {
        Type = "oneshot";
        ExecStart = ''
          ${pkgs.docker}/bin/docker run --env-file /home/mcrowe/Programming/Personal/mbfc/mbfc-mirror-docker/.env --rm mbfc:latest
        '';
      };
    };

    systemd.user.timers = {
      mbfc-docker = {
        Unit.Description = "Build data for mbfc extension";
        Timer = {
          OnCalendar = "daily";
          Persistent = true;
          RandomizedDelaySec = "15 seconds";
          OnUnitActiveSec = "5m";
          Unit = "mbfc-docker.service";
          RemainAfterElapse = true;
        };
        # Install.WantedBy = ["timers.target"];
      };
    };
  };
}
