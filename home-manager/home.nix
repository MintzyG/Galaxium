{ lib, config, pkgs, ... }:

{
  home.username = "sophia";
  home.homeDirectory = "/home/sophia/";
  
  imports = [ 
    ./apps.nix
    ./fish.nix
    ./kitty.nix 
    ./starship.nix
    ./hyprland.nix
  ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "chromium";
    TERMINAL = "kitty";
  };

}
