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
    discord-canary
    firefox
    qimgv
    ranger
    spotify
    vesktop
    zathura
  ];
}
