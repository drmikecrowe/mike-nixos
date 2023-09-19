{ config, pkgs, lib, ... }: {

  environment.systemPackages = with pkgs; [ vscode.fhs ];

}
