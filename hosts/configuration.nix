{ dotfiles
, lib
, pkgs
, config
, hostname
, nixpkgs
, inputs
, user
, timezone
, system
, stateVersion
, ...
}: {
  imports = [
    ../modules/common
    ../modules/nixos
    ./my-system-packages.nix
  ];

  # Nicely reload system units when changing configs
  time.timeZone = timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true; #use same kb settings (layout) as xorg

  # Fix unreadable tty under high dpi
  console = {
    packages = [ pkgs.terminus_font ];
    font = "ter-124n";
  };

  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  environment.localBinInPath = true;

  environment.defaultPackages = [ ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  security = {
    polkit.enable = true;
    pam.loginLimits = [
      {
        domain = "*";
        type = "soft";
        item = "nofile";
        value = "8192";
      }
    ];
  };

  # Needed for nix-* commands to use the system's nixpkgs
  environment.etc."channels/nixpkgs".source = inputs.nixpkgs.outPath;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = stateVersion; # Did you read the comment?
}
