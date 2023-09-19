{ config, pkgs, lib, ... }: {

  config = {

    home-manager.users.${config.user} = {
      services.pass-secret-service = {
        enable = true;
        package = pkgs.libsecret;
      };
    };

  };
}
