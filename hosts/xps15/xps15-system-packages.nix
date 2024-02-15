{
  inputs,
  pkgs,
  ...
}: {
  config = {
    environment.systemPackages = with pkgs; [
      inputs.devenv.packages.${pkgs.system}.devenv
      pinentry-qt
      xclip # Clipboard
    ];
  };
}
