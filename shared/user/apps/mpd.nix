{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ncmpcpp
  ];

  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    network.listenAddress = "any";
    network.startWhenNeeded = true;
    extraConfig = ''
      audio_output {
      type "pipewire"
      name "MPD pipewire"
      }
    '';
  };

  services.mpd-mpris.enable = true;
}
