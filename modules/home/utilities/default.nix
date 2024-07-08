{ pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./eza.nix
    ./hyfetch.nix
    ./kitty.nix
    ./nix-helpers.nix
    ./ranger.nix
    ./taskwarrior.nix
    ./tmux.nix
    ./yazi.nix
  ];

  programs.btop.enable = true;

  home.packages = with pkgs; [
    appimage-run
    brightnessctl
    grim
    ncdu
    ngrok
    pavucontrol
    slurp
    swappy
    tldr
    unrar
    unzip
    wget
    wofi
    xwaylandvideobridge
  ];
}
