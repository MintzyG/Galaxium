{ lib, config, pkgs, inputs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    inputs.nix-gaming.packages.${pkgs.system}.osu-stable
    heroic
    wine
    winetricks
    lutris
    prismlauncher
    gamemode
    protontricks
    protonup-qt
  ];
}
