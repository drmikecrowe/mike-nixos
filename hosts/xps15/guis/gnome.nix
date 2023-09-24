{ config, ... }: {

  config = {
    kde.enable = true;
    lightdm.enable = true;
    nide.enable = false;
    sddm.enable = false;
    budgie.enable = false;
    gnome.enable = false;
    gdm.enable = false;
  };
}
