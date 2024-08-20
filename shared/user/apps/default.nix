{ pkgs, ... }:

{
  imports = [
    ./firefox.nix
  ];

  home.packages = with pkgs; [
    godot_4
    mpv
    obs-studio
    spotify
    vesktop
    wf-recorder
    zathura
  ];
}
