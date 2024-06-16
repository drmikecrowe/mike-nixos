# lifted from https://github.com/t184256/nix-configs/blob/bf08416f7be5511d920a43d9bf2562b05605b0a9/user/xonsh/default.nix
# and https://github.com/NixOS/nixpkgs/pull/314728
{
  lib,
  callPackage,
  coreutils,
  fetchFromGitHub,
  git,
  gitUpdater,
  glibcLocales,
  python3Packages,
}: let
  argset = {
    pname = "xonsh";
    version = "0.16.0-unstable-2024-05-25";
    pyproject = true;

    # PyPI package ships incomplete tests
    src = fetchFromGitHub {
      owner = "xonsh";
      repo = "xonsh";
      # rev = "refs/tags/${argset.version}";
      rev = "1613914d507884487251ecafb55e281699931eb8";
      hash = "sha256-CSElfkeQZi8o8H9WSZtCvzfk6qCSGEC9ctkI0sCBcSs=";
    };

    nativeBuildInputs = with python3Packages; [
      setuptools
      wheel
    ];

    propagatedBuildInputs = with python3Packages; [
      ply
      prompt-toolkit
      pygments
    ];

    nativeCheckInputs =
      [
        git
        glibcLocales
      ]
      ++ (with python3Packages; [
        pip
        pyte
        pytest-mock
        pytest-subprocess
        pytestCheckHook
        requests
      ]);

    disabledTests = [
      # fails on sandbox
      "test_colorize_file"
      "test_loading_correctly"
      "test_no_command_path_completion"
      "test_bsd_man_page_completions"
      "test_xonsh_activator"
      "test_raise_subproc_error_with_show_traceback"
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
    ];

    disabledTestPaths = [
      # fails on sandbox
      "tests/completers/test_command_completers.py"
      "tests/test_ptk_highlight.py"
      "tests/test_ptk_shell.py"
      # fails on non-interactive shells
      "tests/prompt/test_gitstatus.py"
      "tests/completers/test_bash_completer.py"
    ];

    env.LC_ALL = "en_US.UTF-8";

    postPatch = ''
      sed -ie 's|/bin/ls|${lib.getExe' coreutils "ls"}|' tests/test_execer.py
      sed -ie 's|SHELL=xonsh|SHELL=$out/bin/xonsh|' tests/test_integrations.py

      for script in tests/test_integrations.py scripts/xon.sh $(find -name "*.xsh"); do
        sed -ie 's|/usr/bin/env|${lib.getExe' coreutils "env"}|' $script
      done
      patchShebangs .
    '';

    preCheck = ''
      export HOME=$TMPDIR
      export PATH=$out/bin:$PATH
    '';

    passthru = {
      shellPath = "/bin/xonsh";
      python = python3Packages.python; # To the wrapper
      wrapper = callPackage ./wrapper.nix {};
      updateScript = gitUpdater {};
    };

    meta = {
      homepage = "https://xon.sh/";
      description = "A Python-ish, BASHwards-compatible shell";
      changelog = "https://github.com/xonsh/xonsh/raw/main/CHANGELOG.rst";
      license = with lib.licenses; [bsd3];
      mainProgram = "xonsh";
      maintainers = with lib.maintainers; [AndersonTorres];
    };
  };
in
  python3Packages.buildPythonApplication argset
