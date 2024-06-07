{ pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./eza.nix
    ./kitty.nix
    ./ranger.nix
    ./yazi.nix
  ];

  programs.btop.enable = true;

  home.packages = with pkgs; [
    appimage-run
    brightnessctl
    grim
    ncdu
    ngrok
    nh
    nix-index
    nix-output-monitor
    nvd
    pavucontrol
    qimgv
    ranger
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
