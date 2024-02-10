# ce6e212e09fc551e6ed1c784353bd748c6d0733d
# https://github.com/sigoden/argc-completions.git
{
  pkgs,
  lib,
  stdenv,
  fetchFromGitHub,
  installShellFiles,
  runtimeShell,
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
    pkgs.yq-go
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
    cd $out

    mkdir tmp

    initialize() {
      local shell="$1"
      local ext="$2"
      local cmd="''${3:-$shell}"
      local output="argc-completions.$ext"
      echo "#!/usr/bin/env $cmd" > "$out/tmp/$output"
      bash "$out/scripts/display-config.sh" "$shell" | \
        sed 's@\bls\b@/run/current-system/sw/bin/ls@g' | \
        sed 's@/.*/tmp/argc@/tmp/argc@g' | \
        sed 's@argc --argc-completions nushell.*@argc --argc-completions nushell | tee /tmp/argc-completions.nu > /dev/null@g' | \
        tee -a "$out/tmp/$output" > /dev/null
      echo "Initialization for $shell is $out/bin/argc-completions.$shell"
      install -Dm755 $out/tmp/$output $out/bin/$output
    }

    cd $out
    initialize bash bash
    initialize zsh zsh
    initialize fish fish
    initialize nushell nu nu
    initialize powershell ps1
    initialize elvish elv

    cd bin
    installShellCompletion argc-completions.{ba,fi,z}sh
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
