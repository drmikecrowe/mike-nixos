{ config
, dotfiles
, ...
}: {
  imports = [
    ./graphical
    ./shells
    ./terminal
    ./user-services
  ];
}
