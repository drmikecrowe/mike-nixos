# This file defines overlays
{inputs, ...}: let
  patch = pkg: patches:
    pkg.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++ patches;
    });
in rec {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev:
    import ../pkgs {
      inherit inputs;
      pkgs = final;
    };

  # This one contains whatever you want to overlay
  modifications = _final: prev: {
    wavebox = prev.wavebox.overrideAttrs (_old: rec {
      pname = "wavebox";
      version = "10.127.7-2";
      src = prev.fetchurl {
        url = "https://download.wavebox.app/stable/linux/tar/Wavebox_${version}.tar.gz";
        sha256 = "sha256-2KSn98+AH4Ul0cUUxpUcUTrqs/kLYcEOV+q2m7Pmo50=";
        # sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      };
    });
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
