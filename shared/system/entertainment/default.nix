{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gamemode
    osu-lazer-bin
    wine
    winetricks
  ];
}
