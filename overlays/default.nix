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
    # inherit (inputs.nixpkgs-SamLukeYes.legacyPackages.${prev.system}) xonsh;
    #   xonsh = prev.xonsh.overrideAttrs (oldAttrs: {
    #     passthru =
    #       oldAttrs.passthru
    #       ++ (with inputs.xontribs.legacyPackages.x86_64-linux; [
    #         xontrib-chatgpt
    #         xontrib-clp
    #         xontrib-direnv
    #         xontrib-dot-dot
    #         xontrib-gitinfo
    #         xontrib-prompt-starship
    #         xontrib-readable-traceback
    #         xontrib-sh
    #         xontrib-term-integrations
    #         xontrib-zoxide
    #       ]);
    #     disabledTestPaths = [
    #       # fails on sandbox
    #       "tests/completers/test_command_completers.py"
    #       "tests/test_ptk_highlight.py"
    #       "tests/test_ptk_shell.py"
    #       "tests/test_integrations.py"
    #       "tests/test_xontribs.py"
    #       # fails on non-interactive shells
    #       "tests/prompt/test_gitstatus.py"
    #       "tests/completers/test_bash_completer.py"
    #       "tests/completers/test_xompletions.py"
    #       "tests/xoreutils/test_uname.py"
    #       "tests/xoreutils/test_uptime.py"
    #     ];
    #   });
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
