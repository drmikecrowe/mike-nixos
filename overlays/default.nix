# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  modifications = _final: prev: {
    wavebox = prev.wavebox.overrideAttrs (_old: rec {
      pname = "wavebox";
      version = "10.124.23-2";
      src = prev.fetchurl {
        url = "https://download.wavebox.app/stable/linux/tar/Wavebox_${version}.tar.gz";
        # sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        sha256 = "sha256-8wLHYTo5BoVRiqaqIhhCc0M7k3IBAXRg3sjC20j5/SA=";
      };
    });
    # openssh = prev.openssh.overrideAttrs (old: rec {
    #   patches = (old.patches or []) ++ [../patches/openssh.patch];
    #   doCheck = false;
    # });
    #   services.thermald.package = final: prev: prev.thermald.overrideAttrs (old: {
    #     patches = (old.patches or []) ++ [../patches/thermald-422.patch];
    #   });
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
