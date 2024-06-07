{ pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./nix.nix
    ./variables.nix
  ];

  environment.systemPackages = with pkgs; [ home-manager ];
  system.stateVersion = "23.11";
}
