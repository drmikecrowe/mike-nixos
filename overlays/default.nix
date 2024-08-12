# This file defines overlays
{inputs, ...}: let
  patch = pkg: patches:
    pkg.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++ patches;
    });
in {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev:
    import ../pkgs {
      inherit inputs;
      pkgs = final;
    };

  # This one contains whatever you want to overlay
  modifications = _final: prev: {
    # openssh = prev.openssh.overrideAttrs (old: rec {
    #   postPatch = ''
    #     sed -i 's/1/0/' $(grep '#define SSHCONF_CHECKPERM' * -rl)
    #     grep SSHCONF_CHECKPERM . -r
    #   '';
    # });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };
}
