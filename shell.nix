{ pkgs }:

with pkgs;
mkShell {
  name = "flakeEnv";
  buildInputs = [ rnix-lsp statix ];
  shellHook = ''
    alias nrt="sudo nixos-rebuild test --flake path:.#xps15 --impure"
    alias nru="sudo nixos-rebuild switch --flake path:.#xps15 --upgrade --impure"
    alias nrs="statix check && nix fmt && nixos-rebuild build --flake path:.#xps15 --impure && sudo nixos-rebuild switch --flake path:.#xps15 --impure && git add . && git commit";
  '';
}
