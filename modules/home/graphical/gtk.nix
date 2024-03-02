_: {
  gtk = {
    gtk2.extraConfig = ''
      gtk-theme-name =" "palenight""
      gtk-theme-name =" "palenight""
      gtk-theme-name =" "palenight""
      gtk-toolbar-style="3"
      gtk-menu-images="1"
      gtk-button-images="1"
      gtk-cursor-theme-size="24"
      gtk-cursor-theme-name="breeze_cursors"
      gtk-icon-theme-name="DamaDamas-icon-theme-0.7"
      gtk-font-name="NotoSans NF Med,  11"
    '';
    gtk3.extraConfig = {
      Settings = ''
        gtk-decoration-layout="icon:minimize,maximize,close"
        gtk-enable-animations="true"
        gtk-font-name="NotoSans NF Med,  11"
        gtk-icon-theme-name="DamaDamas-icon-theme-0.7"
        gtk-menu-images="true"
        gtk-modules="colorreload-gtk-module"
        gtk-primary-button-warps-slider="false"
        gtk-toolbar-style="3"
        gtk-xft-dpi="98304"
        gtk-cursor-theme-name="Numix-Cursor"
        gtk-icon-theme-name="Papirus-Dark"
        gtk-theme-name="palenight"
        gtk-cursor-theme-name="Numix-Cursor"
        gtk-icon-theme-name="Papirus-Dark"
        gtk-theme-name="palenight"
        gtk-cursor-theme-name="Numix-Cursor"
        gtk-icon-theme-name="Papirus-Dark"
        gtk-theme-name="palenight"
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-enable-animations="true"
        gtk-font-name="NotoSans NF Med,  11"
        gtk-icon-theme-name="DamaDamas-icon-theme-0.7"
        gtk-modules="colorreload-gtk-module"
        gtk-primary-button-warps-slider="false"
        gtk-xft-dpi="98304"
        gtk-cursor-theme-name="Numix-Cursor"
        gtk-icon-theme-name="Papirus-Dark"
        gtk-theme-name="palenight"
        gtk-cursor-theme-name="Numix-Cursor"
        gtk-icon-theme-name="Papirus-Dark"
        gtk-theme-name="palenight"
        gtk-cursor-theme-name="Numix-Cursor"
        gtk-icon-theme-name="Papirus-Dark"
        gtk-theme-name="palenight"
      '';
    };
  };
}
