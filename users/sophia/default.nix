{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  imports = [
    ../../shared/user/apps/firefox.nix
    ../../shared/user/development/c.nix
    ../../shared/user/development/git.nix
    ../../shared/user/development/go.nix
    ../../shared/user/development/lazygit.nix
    #../../shared/user/development/nvim.nix
    ../../shared/user/shell/fish.nix
    ../../shared/user/shell/starship.nix
    ../../shared/user/utilities/eza.nix
    ../../shared/user/utilities/yazi.nix
    ../../shared/user/utilities/kitty.nix
  ];

  home = {
    stateVersion = "24.05";
    username = "sophia";
    homeDirectory = "/home/sophia/";
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
    };
    packages = with pkgs; [ 
      discord
    ];
  };
}