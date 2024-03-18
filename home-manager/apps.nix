{ lib, config, pkgs, ... }:
{
  programs.btop.enable = true;

  home.packages = with pkgs; [
    ranger
  ];
}
