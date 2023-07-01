{ ... }:

{
  programs.ssh = {
    enable = true;
    "*" = {
      identitiesOnly = true;
      identityAgent = "~/.1password/agent.sock";
    };
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
}
