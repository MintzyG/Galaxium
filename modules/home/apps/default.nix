{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    godot_4
    mpv
    obs-studio
    spotify
    vesktop
    wf-recorder
    zathura
  ];
}
