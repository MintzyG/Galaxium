{ pkgs, ... }:

{
  imports = [
    ./entertainment
    ./hardware
    ./networking
    ./system
    ./user
  ];
}
