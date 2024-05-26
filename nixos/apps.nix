{ pkgs, ... }:

{
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    mpv
    ngrok
    texliveFull
    unrar
    unzip
    wget
  ];
}
