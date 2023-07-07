{ pkgs }:

with pkgs;
mkShell {
  name = "flakeEnv";
  buildInputs = [ rnix-lsp statix ];
  shellHook = ''
    alias nrt="statix check && nix fmt && sudo nixos-rebuild test --flake path:.#xps15 --impure"
    alias nrb="statix check && nix fmt && nixos-rebuild build --flake path:.#xps15 --impure && sudo nixos-rebuild switch --flake path:.#xps15 --impure && git add . && git commit";
    alias nru="statix check && nix fmt && nixos-rebuild build --flake path:.#xps15 --impure && sudo nixos-rebuild switch --flake path:.#xps15 --impure --upgrade && git add . && git commit";
  '';
}
