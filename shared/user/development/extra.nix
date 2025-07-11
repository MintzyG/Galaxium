{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nsis
    upx
  ];
}
