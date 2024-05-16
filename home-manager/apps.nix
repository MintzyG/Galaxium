{ lib, config, pkgs, ... }:
{
  programs.btop.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home.packages = with pkgs; [
    ranger
  ];
}
