{ pkgs, ... }:

{
  home.packages = with pkgs; [
    beam26Packages.elixir
    premake5
    nsis
    upx
  ];
}
