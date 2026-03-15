{ pkgs, ... }:
{
  programs.go = {
    enable = true;
    env.GOPATH = "/home/sophia/.config/go";
  };
  home.packages = with pkgs; [
    jetbrains.goland
    sqlc
    go-swag
  ];
}
