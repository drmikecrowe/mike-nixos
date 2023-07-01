{ config, pkgs, ... }:

{
  users = {
    mutableUsers = false;
    users = {

      root = {
        initialHashedPassword = "$6$nyAyhpkgir6zpMf8$IRXqqoAe9tZn86T1g7pRKWqMP/vlKAYnFiYHBj9GP/x8KChSmvYGzezy2dxq4NwiyE8X18ygxOJCLC6oSwJlq0";
      };
    };
  };

}
