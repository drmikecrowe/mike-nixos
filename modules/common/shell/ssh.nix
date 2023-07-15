{ config, pkgs, lib, ... }: {

  home-manager.users.${config.user} = {

    programs.ssh = {
      enable = true;
      extraConfig = ''
        Host *
            IdentitiesOnly=yes
            IdentityAgent ~/.1password/agent.sock
      '';
      matchBlocks = {
        "pod*" = {
          user = "mcrowe";
          identityFile = "~/.ssh/id_rsa_pi.pub";
        };
        "source.developers.google.com" = {
          hostname = "source.developers.google.com";
          user = "mike.crowe@mikkeltech.com";
          identityFile = "~/.ssh/id_rsa_mikkel";
        };
        "osmc" = {
          hostname = "crowenas.local";
          user = "root";
          identityFile = "~/.ssh/id_rsa_drmikecrowe.pub";
        };
        "remarkable" = {
          hostname = "192.168.12.131";
          user = "root";
          identityFile = "~/.ssh/id_rsa_drmikecrowe";
        };
        "bastion-dev" = {
          hostname = "53.23.141.176";
          identityFile = "~/.ssh/pinnsg-ue1-dev-infrastructure-ssh-key.pub";
        };
        "qbconnector-dev" = {
          hostname = "52.20.144.2";
          user = "bitnami";
          identityFile = "~/.ssh/pinnsg-ue1-dev-infrastructure-ssh-key.pub";
        };
        "bastion-data" = {
          hostname = "52.206.233.147";
          identityFile = "~/.ssh/pinnsg-ue1-data-infrastructure-ssh-key.pub";
        };
      };
    };
    home.file.".ssh/Gitpod.pub".source = ./config/ssh/Gitpod.pub;
    home.file.".ssh/id_rsa.pub".source = ./config/ssh/id_rsa.pub;
    home.file.".ssh/id_rsa_drmikecrowe-github.pub".source =
      ./config/ssh/id_rsa_drmikecrowe-github.pub;
    home.file.".ssh/id_rsa_drmikecrowe.pub".source =
      ./config/ssh/id_rsa_drmikecrowe.pub;
    home.file.".ssh/id_rsa_drmikecrowe-ubuntu-rsa.pub".source =
      ./config/ssh/id_rsa_drmikecrowe-ubuntu-rsa.pub;
    home.file.".ssh/id_rsa_mikkel.pub".source = ./config/ssh/id_rsa_mikkel.pub;
    home.file.".ssh/id_rsa-personal-git.pub".source =
      ./config/ssh/id_rsa-personal-git.pub;
    home.file.".ssh/id_rsa_pinnsg.pub".source = ./config/ssh/id_rsa_pinnsg.pub;
    home.file.".ssh/id_rsa_pi.pub".source = ./config/ssh/id_rsa_pi.pub;
    home.file.".ssh/pinnsg-ue1-data-infrastructure-ssh-key.pub".source =
      ./config/ssh/pinnsg-ue1-data-infrastructure-ssh-key.pub;
    home.file.".ssh/pinnsg-ue1-dev-infrastructure-ssh-key.pub".source =
      ./config/ssh/pinnsg-ue1-dev-infrastructure-ssh-key.pub;
  };
}
