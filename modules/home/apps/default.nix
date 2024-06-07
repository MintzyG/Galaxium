{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    spotify
    vesktop
    zathura
  ];
}
