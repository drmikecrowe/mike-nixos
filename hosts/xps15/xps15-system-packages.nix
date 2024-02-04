{ inputs, pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      inputs.devenv.packages.${pkgs.system}.devenv
      etcher
      libreoffice
      xclip # Clipboard
    ];
  };
}
