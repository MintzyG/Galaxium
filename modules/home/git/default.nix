{ pkgs, ... }:

{
  imports = [
    ./git.nix
    ./lazygit.nix
  ];

  home.packages = with pkgs; [
    gh
  ];
}
