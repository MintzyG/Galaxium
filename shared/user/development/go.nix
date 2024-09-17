{ pkgs, ... }:

{
  home.packages = with pkgs; [
  # Make GO-PATH not be in home, make it .config
    go
  ];
}
