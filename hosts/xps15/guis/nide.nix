{ config, ... }: {

  config = {
    nide.enable = true;
    sddm.enable = true;
    lightdm.enable = false;
    kde.enable = false;
    budgie.enable = false;
    gnome.enable = false;
    gdm.enable = false;
  };
}
