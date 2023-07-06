{ pkgs }:

with pkgs;
mkShell {
  name = "flakeEnv";
  buildInputs = [ rnix-lsp ];
  shellHook = ''
    alias nrb="nixos-rebuild build --flake path:.#xps15 --impure"
    alias nrt="sudo nixos-rebuild test --flake path:.#xps15 --impure"
    alias nrs="sudo nixos-rebuild switch --flake path:.#xps15 --impure"
    alias nru="sudo nixos-rebuild switch --flake path:.#xps15 --upgrade --impure"
    alias nfs="nix fmt && nixos-rebuild build --flake path:.#xps15 --impure && sudo nixos-rebuild switch --flake path:.#xps15 --impure && git add . && git commit";
  '';
}
