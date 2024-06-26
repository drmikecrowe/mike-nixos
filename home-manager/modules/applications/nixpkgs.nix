{
  config,
  pkgs,
  dotfiles,
  ...
}: {
  programs.fish = {
    shellAbbrs = {
      n = "nix";
      ns = "nix-shell -p";
      nsf = "nix-shell --run fish -p";
      nsr = "nix-shell-run";
      nps = "nix repl '<nixpkgs>'";
      nixo = "man configuration.nix";
      nixh = "man home-configuration.nix";
      nr = "rebuild-nixos";
      nro = "rebuild-nixos offline";
      hm = "rebuild-home";
    };
    functions = {
      nix-shell-run = {
        body = ''
          set program $argv[1]
          if test (count $argv) -ge 2
              commandline -r "nix run nixpkgs#$program -- $argv[2..-1]"
          else
              commandline -r "nix run nixpkgs#$program"
          end
          commandline -f execute
        '';
      };
      nix-fzf = {
        body = ''
          commandline -i (nix-instantiate --eval --json \
            -E 'builtins.attrNames (import <nixpkgs> {})' \
            | jq '.[]' -r | fzf)
          commandline -f repaint
        '';
      };
    };
  };
}
