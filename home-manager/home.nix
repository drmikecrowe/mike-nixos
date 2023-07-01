# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./apps/console/git
    ./apps/console/ssh
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "mcrowe";
    homeDirectory = "/home/mcrowe";

    packages = with pkgs; [
      # web
      firefox
      vivaldi

      nodejs
      nodePackages_latest.typescript-language-server

      # python
      # python39
      # (python39.withPackages (ps: [ ps.epc ps.python-lsp-server ]))
      # python39Full
      # python39Packages.pip
      # python39Packages.python-lsp-server

      # desktop apps
      virt-manager
      neofetch
      rustscan
      atuin
      kitty
      unstable._1password-gui-beta
      unstable.vscode
      unstable.nushell
      meld
      python311
      python311Packages.pip
      cargo
      nodejs_18
      neovide
      xclip

      libreoffice
      peek
      zoom-us
      teams

      # command line utils
      mg
      jq
      ripgrep
      unzip
      nix-prefetch-github
      killall

      # libs
      ffmpeg
      libnotify

      # misc
      acpi
      sshfs
    ];
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;

  programs = {
    home-manager.enable = true;
    neovim.enable = true;

    git.enable = true; 
    nix-index.enable = true;

    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
