# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  # Get 1.3.0 to addres infinite loop:
  # - https://github.com/Cisco-Talos/clamav/pull/1047
  modifications = _final: prev: {
    wavebox = prev.wavebox.overrideAttrs (_old: rec {
      pname = "wavebox";
      # version = "10.121.6-2";
      version = "10.123.5-2";
      src = prev.fetchurl {
        url = "https://download.wavebox.app/stable/linux/tar/Wavebox_${version}.tar.gz";
        sha256 = "sha256-pUw8gIoXg1Hx3MgxkgS0oLqoJ/xRNA6NgZhNHwA+iJ4=";
      };
    });
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
# { inputs, ... }:
# {
#   additions = final: _prev: import ../pkgs { pkgs = final; };
#   services.thermald.package = final: prev: prev.thermald.overrideAttrs (old: {
#     patches = (old.patches or []) ++ [../patches/thermald-422.patch];
#   });
#   openssh = final: prev: prev.openssh.overrideAttrs (old: {
#     patches = (old.patches or []) ++ [../patches/openssh.patch];
#     doCheck = false;
#   });
# }
# final: prev: {
#   additions = final: _prev: import ../pkgs {pkgs = final;};
#   services.thermald.package = prev.thermald.overrideAttrs (old: {
#     patches = (old.patches or []) ++ [../patches/thermald-422.patch];
#   });
#   openssh = prev.openssh.overrideAttrs (old: {
#     patches = (old.patches or []) ++ [../patches/openssh.patch];
#     doCheck = false;
#   });
#   argc-completions = prev.callPackage ./argc-completions.nix {};
# }

