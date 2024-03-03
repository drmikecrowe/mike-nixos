{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  config = lib.mkIf config.custom.vivaldi {
    environment.systemPackages = with pkgs; [
      vivaldi
      vivaldi-ffmpeg-codecs
    ];

    nixpkgs.config = {
      vivaldi = {
        proprietaryCodecs = true;
      };
    };
  };
}
