{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    gamemode
    heroic
    lutris
    osu-lazer-bin
    prismlauncher
    protontricks
    protonup-qt
    wine
    winetricks
  ];
}
