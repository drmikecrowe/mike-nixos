{ config, pkgs, lib, ... }: {

  home-manager.users.${config.user} = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
  };

}
