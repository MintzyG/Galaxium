{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    gamemode
    osu-lazer-bin
    protontricks
    protonup-qt
    wine
    winetricks
  ];
}
