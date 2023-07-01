{ config, ... }:

{
  programs.ssh = {
    enable = true;
  };
  home.file.".ssh".source = ./ssh;
}
