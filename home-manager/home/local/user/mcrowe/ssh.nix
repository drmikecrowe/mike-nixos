{
  config,
  dotfiles,
  lib,
  secrets,
  username,
  ...
}: let
  # onePassPath = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  onePassPath = "~/.1password/agent.sock";
  cfg = config.host.home.feature.ssh;
in {
  config = lib.mkIf cfg.enable {
    programs.ssh = {
      extraConfig = ''
        Host *
            IdentitiesOnly=yes
            IdentityAgent ${onePassPath}
      '';
      matchBlocks = {
        "pod*" = {
          user = "${username}";
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
          hostname = secrets.ssh.bastion-dev;
          forwardAgent = true;
          identityFile = "~/.ssh/pinnsg-ue1-dev-infrastructure-ssh-key.pub";
        };
        "bastion-data" = {
          hostname = secrets.ssh.bastion-data;
          identityFile = "~/.ssh/pinnsg-ue1-data-infrastructure-ssh-key.pub";
        };
        "bastion-prod" = {
          hostname = secrets.ssh.bastion-prod;
          identityFile = "~/.ssh/pinnsg-ue1-prod-infrastructure-ssh-key.pub";
        };
      };
    };

    home.file = {
      ".ssh/Gitpod.pub".source = "${dotfiles}/ssh/Gitpod.pub";
      ".ssh/id_rsa.pub".source = "${dotfiles}/ssh/id_rsa.pub";
      ".ssh/id_ed25519.pub".source = "${dotfiles}/ssh/id_ed25519.pub";
      ".ssh/id_rsa_drmikecrowe-github.pub".source = "${dotfiles}/ssh/id_rsa_drmikecrowe-github.pub";
      ".ssh/id_rsa_drmikecrowe.pub".source = "${dotfiles}/ssh/id_rsa_drmikecrowe.pub";
      ".ssh/id_rsa_drmikecrowe-ubuntu-rsa.pub".source = "${dotfiles}/ssh/id_rsa_drmikecrowe-ubuntu-rsa.pub";
      ".ssh/id_rsa_mikkel.pub".source = "${dotfiles}/ssh/id_rsa_mikkel.pub";
      ".ssh/id_rsa-personal-git.pub".source = "${dotfiles}/ssh/id_rsa-personal-git.pub";
      ".ssh/id_rsa_pinnsg.pub".source = "${dotfiles}/ssh/id_rsa_pinnsg.pub";
      ".ssh/id_rsa_pi.pub".source = "${dotfiles}/ssh/id_rsa_pi.pub";
      ".ssh/pinnsg-ue1-data-infrastructure-ssh-key.pub".source = "${dotfiles}/ssh/pinnsg-ue1-data-infrastructure-ssh-key.pub";
      ".ssh/pinnsg-ue1-dev-infrastructure-ssh-key.pub".source = "${dotfiles}/ssh/pinnsg-ue1-dev-infrastructure-ssh-key.pub";
    };
  };
}
