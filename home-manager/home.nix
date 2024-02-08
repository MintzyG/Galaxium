{ lib, config, pkgs, ... }:

{
  home.username = "sophia";
  home.homeDirectory = "/home/sophia/";
  
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
