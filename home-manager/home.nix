{ lib, config, pkgs, ... }:

{
  home.username = "sophia";
  home.homeDirectory = "/home/sophia/";
  
  imports = [ ./kitty.nix ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
  };

}
