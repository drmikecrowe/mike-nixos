{
  inputs,
  config,
  lib,
  pkgs,
  username,
  ...
}:
with lib; {
  home = {
    # For compatibility with nix-shell, nix-build, etc.
    # file.".nixpkgs".source = inputs.nixpkgs;
    # sessionVariables."NIX_PATH" = "nixpkgs=$HOME/.nixpkgs\${NIX_PATH:+:}$NIX_PATH";
    activation = {
      # link_libgit2 = ''
      #   # Remove the existing symlink if it exists
      #   if [ -L /usr/lib/libgit2.so ]; then
      #       sudo rm /usr/lib/libgit2.so
      #   fi
      #
      #   # Create a new symlink to the current version of libgit2
      #   sudo ln -sf ${pkgs.libgit2.out}/lib/libgit2.so /usr/lib/libgit2.so
      # '';
      profile_directories_state_create = ''
        if [ -d "$HOME"/.cache ]; then
            mkdir -p "$HOME"/.cache
        fi

        if [ -d "$HOME"/.local/share ]; then
            mkdir -p "$HOME"/.local/share
        fi

        if [ -d "$HOME"/.local/state ]; then
            mkdir -p "$HOME"/.local/state
        fi

        if [ -d "$HOME"/.config ]; then
            mkdir -p "$HOME"/.config
        fi
      '';
    };
    stateVersion = mkDefault "23.11";
  };

  # Use the same Nix configuration throughout the system.
  xdg.configFile."nixpkgs/config.nix".source = ../../../nix/config.nix;

  manual.manpages.enable = mkDefault false;
  news.display = mkDefault "show";

  programs = {
    home-manager = {
      enable = mkForce true;
    };
  };
}
