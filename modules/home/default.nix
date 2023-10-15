{ config
, dotfiles
, ...
}: {
  imports = [
    ./graphical
    ./terminal
    ./user-services
  ];
}
