{ pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./nix.nix
    ./variables.nix
  ];
  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [ 
    home-manager 
    gparted
  ];
  system.stateVersion = "23.11";
}
