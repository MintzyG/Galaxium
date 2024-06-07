{ pkgs, ... }:
{
  programs.btop.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.packages = with pkgs; [
    appimage-run
    firefox
    ncdu
    qimgv
    ranger
    spotify
    vesktop
    zathura
  ];
}
