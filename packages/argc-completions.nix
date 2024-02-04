# ce6e212e09fc551e6ed1c784353bd748c6d0733d
# https://github.com/sigoden/argc-completions.git
{
  pkgs,
  lib,
  stdenv,
  fetchFromGitHub,
  installShellFiles,
  runtimeShell,
  enableShells ? ["fish" "bash" "zsh"],
}:
stdenv.mkDerivation rec {
  pname = "argc-completions";
  version = "2023-12-29";
  rev = "ce6e212e09fc551e6ed1c784353bd748c6d0733d";
  sha256 = "sha256-wHeHa8TXpcexICe/abV9a5zN+1/QzZXQhGsFIgdAf0o=";
  phases = [
    "unpackPhase"
    "installPhase"
    "postInstall"
  ];

  src = fetchFromGitHub {
    owner = "sigoden";
    repo = "argc-completions";
    inherit rev;
    inherit sha256;
  };

  runtimeDependencies = [
    pkgs.argc
    pkgs.yq
  ];

  nativeBuildInputs = [
    installShellFiles
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp -- Argcfile.sh "$out"
    cp -r -- completions "$out"
    cp -r -- scripts "$out"
    cp -r -- src "$out"
    cp -r -- utils "$out"
    sed 's/^main.*@.*/_setup_script \$1/' $out/scripts/setup-shell.sh > $out/scripts/display-config.sh
  '';

  postInstall = ''
    SHELL_INITS="$out/shell-inits"
    mkdir -p $SHELL_INITS
    cd $out

    for shell in bash zsh ps1 fish nu elv xsh tcsh; do
      bash $out/scripts/display-config.sh $shell > $SHELL_INITS/argc.$shell
      chmod +x $SHELL_INITS/argc.$shell
    done

    for shell in ${lib.escapeShellArgs enableShells}; do
      echo "Installing shell completions for $shell via $SHELL_INITS/argc.$shell"
      installShellCompletion --name argc-completions --$shell <(cat $SHELL_INITS/argc.$shell)
    done

    cat <<SCRIPT > $out/bin/argc-completions-folder
    #!${runtimeShell}
    # Run this script to find the argc-completions shared folder where all the shell
    # integration scripts are living.
    echo $SHELL_INITS
    SCRIPT
    chmod +x $out/bin/argc-completions-folder
  '';

  meta = with lib; {
    description = "Argc-completions provides completion definitions that work for any shell.";
    homepage = "https://github.com/sigoden/argc-completions";
    license = licenses.mit;
    platforms = platforms.linux;
    # maintainers = with maintainers; [ rob relrod SuperSandro2000 ];
    # changelog = "https://github.com/htop-dev/htop/blob/${version}/ChangeLog";
    # mainProgram = "htop";
  };
}
