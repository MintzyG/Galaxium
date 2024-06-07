{ pkgs, ... }:

{
  imports = [
    ./entertainment
    ./hardware
    ./networking
    ./system
    ./user
  ];

  environment.systemPackages = with pkgs; [
    texliveFull
  ];
}
