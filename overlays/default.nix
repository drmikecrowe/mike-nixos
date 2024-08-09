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
    wavebox = prev.wavebox.overrideAttrs (oldAttrs: rec {
      pname = "wavebox";
      version = "10.127.7-2";
      src = prev.fetchurl {
        url = "https://download.wavebox.app/stable/linux/tar/Wavebox_${version}.tar.gz";
        sha256 = "sha256-2KSn98+AH4Ul0cUUxpUcUTrqs/kLYcEOV+q2m7Pmo50=";
        # sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      };
    });
    xonsh = prev.xonsh.overrideAttrs (oldAttrs: {
      propagatedBuildInputs =
        oldAttrs.propagatedBuildInputs
        ++ (with inputs.xontribs.legacyPackages.x86_64-linux; [
          xontrib-chatgpt
          xontrib-clp
          xontrib-direnv
          xontrib-dot-dot
          xontrib-gitinfo
          xontrib-prompt-starship
          xontrib-readable-traceback
          xontrib-sh
          xontrib-term-integrations
          xontrib-zoxide
        ]);
      disabledTests = [
        # fails on sandbox
        "test_colorize_file"
        "test_loading_correctly"
        "test_no_command_path_completion"
        "test_bsd_man_page_completions"
        "test_xonsh_activator"

        # fails on non-interactive shells
        "test_capture_always"
        "test_casting"
        "test_command_pipeline_capture"
        "test_dirty_working_directory"
        "test_man_completion"
        "test_vc_get_branch"
        "test_bash_and_is_alias_is_only_functional_alias"

        # flaky tests
        "test_script"
        "test_alias_stability"
        "test_alias_stability_exception"
        "test_complete_import"
        "test_subproc_output_format"

        # https://github.com/xonsh/xonsh/issues/5569
        "test_spec_modifier_alias_output_format"
      ];

      disabledTestPaths = [
        # fails on sandbox
        "tests/completers/test_command_completers.py"
        "tests/test_ptk_highlight.py"
        "tests/test_ptk_shell.py"
        "tests/test_integrations.py"
        "tests/test_xontribs.py"
        # fails on non-interactive shells
        "tests/prompt/test_gitstatus.py"
        "tests/completers/test_bash_completer.py"
        "tests/completers/test_xompletions.py"
        "tests/xoreutils/test_uname.py"
        "tests/xoreutils/test_uptime.py"
      ];
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
