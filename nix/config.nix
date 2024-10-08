# https://github.com/davidtwco/veritas/blob/master/flake.nix
{
  allowBroken = true;
  allowUnfree = true;
  allowUnsupportedSystem = false;
  permittedInsecurePackages = [
  ];
  experimental-features = ["nix-command" "flakes"];
  extra-substituters = [
    "https://cache.nixos.org/"
    "https://numtide.cachix.org"
    "https://nixpkgs-update.cachix.org"
    "https://nix-community.cachix.org"
    "https://devenv.cachix.org"
    "https://xonsh-xontribs.cachix.org"
  ];

  extra-trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "nixpkgs-update.cachix.org-1:6y6Z2JdoL3APdu6/+Iy8eZX2ajf09e4EE9SnxSML1W8="
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    "xonsh-xontribs.cachix.org-1:LgP0Eb1miAJqjjhDvNafSrzBQ1HEtfNl39kKtgF5LBQ="
  ];
}
