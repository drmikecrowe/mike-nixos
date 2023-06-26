{ pkgs, ... }: {
  # Desktop application momentum follows the unstable channel.
  programs = {
    firefox = {
      enable = true;
      package = pkgs.unstable.firefox;
    };
  };

  environment.systemPackages = with pkgs.unstable; [
    authy
    discord
    gimp-with-plugins
    gnome.dconf-editor
    libreoffice
    meld
    remmina
    slack
    vivaldi
    vivaldi-ffmpeg-codecs
    vscode-fhs
    wavebox
    zoom-us
  ];
}
