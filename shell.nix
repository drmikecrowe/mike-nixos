{ pkgs }:

with pkgs;
mkShell {
  name = "flakeEnv";
  buildInputs = [ rnix-lsp ];
  shellHook = ''
    alias nrb="nixos-rebuild build --flake .mcrowe@#xps15 --impure"
    alias nrt="sudo nixos-rebuild test --flake .#xps15 --impure"
    alias nrs="sudo nixos-rebuild switch --flake .#xps15 --impure"

    alias build-laptop="nixos-rebuild switch --flake .#laptop"
  '';
}
