# ce6e212e09fc551e6ed1c784353bd748c6d0733d
# https://github.com/sigoden/argc-completions.git
{ pkgs
, lib
, stdenv
, fetchFromGitHub
, installShellFiles
, enableShells ? [ "bash" "zsh" "fish" ]
,
}:
stdenv.mkDerivation rec {
  pname = "argc-completions";
  version = "2023-12-29";
  rev = "ce6e212e09fc551e6ed1c784353bd748c6d0733d";
  sha256 = "sha256-wHeHa8TXpcexICe/abV9a5zN+1/QzZXQhGsFIgdAf0o=";

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

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    cp -- Argcfile.sh "$out"
    cp -r -- completions "$out"
    cp -r -- scripts "$out"
    cp -r -- src "$out"
    cp -r -- utils "$out"
    pushd $out
    sed 's/^main.*@.*/_setup_script \$1/' $out/scripts/setup-shell.sh > $out/scripts/display-config.sh
    mkdir -p $HOME/.config/argc-completions;
    for shell in bash zsh powershell fish nushell elvish xonsh tcsh; do
      bash $out/scripts/display-config.sh $shell > $HOME/.config/argc-completions/argc.$shell.sh
    done
    for shell in ${lib.escapeShellArgs enableShells}; do
      installShellCompletion --$shell $HOME/.config/argc-completions/argc.$shell.sh
    done
    popd
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
