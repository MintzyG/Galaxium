{ pkgs, ... }:

{
  home.packages = with pkgs; [
    appimage-run
    brightnessctl
    grim
    ncdu
    ngrok
    pavucontrol
    slurp
    swappy
    unrar
    unzip
  ];
}
