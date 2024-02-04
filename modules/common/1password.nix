{ config
, pkgs
, lib
, user
, dotfiles
, ...
}: {
  config = lib.mkIf config.custom._1password {

    programs = {
      _1password.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "${user}" ];
      };
    };

    home-manager.users.${user} = {
      home.file.".config/autostart/1password-startup.desktop".source = "${dotfiles}/autostart/1password-startup.desktop";
    };

    environment.etc = {
      "1password/custom_allowed_browsers".text = ''
        vivaldi-bin
      '';
    };
  };
}
