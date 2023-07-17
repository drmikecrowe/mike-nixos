{ config, pkgs, lib, ... }: {

  options.gpg.enable = lib.mkEnableOption "GnuPG encryption.";

  config.programs = lib.mkIf config.gpg.enable {
    gnupg.agent.enable = true;
  };

  config.home-manager.users.${config.user} = lib.mkIf config.gpg.enable {
    programs = {
      gpg.enable = true;
    };

    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 86400; # Resets when used
      defaultCacheTtlSsh = 86400; # Resets when used
      maxCacheTtl = 34560000; # Can never reset
      maxCacheTtlSsh = 34560000; # Can never reset
      pinentryFlavor = if config.gui.enable then "gtk2" else "tty";
    };
    home = lib.mkIf config.gui.enable { packages = with pkgs; [ pinentry ]; };
  };

}
