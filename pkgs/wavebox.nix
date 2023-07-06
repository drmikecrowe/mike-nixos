{ alsaLib
, autoPatchelfHook
, fetchurl
, gtk3
, lib
, libnotify
, makeDesktopItem
, makeWrapper
, nss
, stdenv
, udev
, xdg_utils
, xorg
}:


with lib;

let
  sha256 = "sha256-WpvDvUDIuAQCbP/ffhfLzotwRia1DeaDPR/gaj0tPC4=";

  desktopItem = makeDesktopItem rec {
    name = "Wavebox";
    exec = "wavebox";
    icon = "wavebox";
    desktopName = name;
    genericName = name;
    categories = [ "Email" "Network" ];
  };

in
stdenv.mkDerivation {
  pname = "wavebox";
  inherit version;
  src = builtins.fetchTarball {
    url = "https://download.wavebox.app/latest/stable/linux/tar";
  };

  # don't remove runtime deps
  dontPatchELF = true;

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];

  buildInputs = with xorg; [
    libXdmcp
    libXScrnSaver
    libXtst
  ] ++ [
    alsaLib
    gtk3
    nss
  ];

  runtimeDependencies = [
    (getLib udev)
    libnotify
  ];

  installPhase = ''
    mkdir -p $out/bin $out/opt/wavebox
    cp -r * $out/opt/wavebox

    # provide desktop item and icon
    mkdir -p $out/share/applications $out/share/pixmaps
    ln -s ${desktopItem}/share/applications/* $out/share/applications
    ln -s $out/opt/wavebox/Wavebox-linux-x64/wavebox_icon.png $out/share/pixmaps/wavebox.png
  '';

  postFixup = ''
    makeWrapper $out/opt/wavebox/wavebox $out/bin/wavebox \
      --prefix PATH : ${xdg_utils}/bin
  '';

  meta = with lib; {
    description = "Wavebox messaging application";
    homepage = "https://wavebox.io";
    license = licenses.mpl20;
    maintainers = with maintainers; [ rawkode ];
    platforms = [ "x86_64-linux" ];
    hydraPlatforms = [ ];
  };
}