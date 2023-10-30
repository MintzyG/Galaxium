{ config, pkgs, ... }:

{
  home.username = "sophia";
  home.homeDirectory = "/home/sophia";
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    jetbrains.goland
    spotify
    go
  ];
  programs.home-manager.enable = true;
}
