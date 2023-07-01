{ pkgs }:

with pkgs;
mkShell {
  name = "flakeEnv";
  buildInputs = [ rnix-lsp ];
  shellHook = ''
    alias nrb="nixos-rebuild build --flake .#xps15 --impure"
    alias nrt="sudo nixos-rebuild test --flake .#xps15 --impure"
    alias nrsh="nixos-rebuild switch --flake .#mcrowe@xps15"
    alias nrss="sudo nixos-rebuild switch --flake .#xps15 --impure"
  '';
}
