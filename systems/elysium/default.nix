{ config, pkgs, ... }:

{
  imports = [
    ../shared/entertainment
    ../shared/hardware
    ../shared/networking
    ../shared/system
    ../shared/user
  ];
}
