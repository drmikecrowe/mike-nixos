{ config, ... }: {

  config = {
    gnome.enable = true;
    gdm.enable = true;
    kde.enable = false;
    budgie.enable = false;
    nide.enable = false;
    sddm.enable = false;
    lightdm.enable = false;
  };
}
