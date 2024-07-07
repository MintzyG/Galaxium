{ pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./eza.nix
    ./kitty.nix
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
    nh
    nix-index
    nix-output-monitor
    nvd
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
