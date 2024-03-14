{config, ...}: {
  gtk = {
    gtk2.extraConfig = ''
      gtk-button-images="1"
      gtk-cursor-theme-name="breeze_cursors"
      gtk-cursor-theme-size="24"
      gtk-font-name="NotoSans NF Med,  11"
      gtk-icon-theme-name="DamaDamas-icon-theme-0.7"
      gtk-menu-images="1"
      gtk-theme-name =" "palenight""
      gtk-toolbar-style="3"
    '';
    gtk3.extraConfig = {
      gtk-font-name = "NotoSans NF Med,  11";
      gtk-icon-theme-name = "Papirus-Dark";
      gtk-modules = "colorreload-gtk-module";
      gtk-primary-button-warps-slider = "false";
      gtk-theme-name = "palenight";
      gtk-toolbar-style = "3";
      gtk-xft-dpi = "98304";
    };
    gtk4.extraConfig = {
      gtk-icon-theme-name = "Papirus-Dark";
      gtk-modules = "colorreload-gtk-module";
      gtk-primary-button-warps-slider = "false";
      gtk-theme-name = "palenight";
      gtk-xft-dpi = "98304";
    };
  };
}
