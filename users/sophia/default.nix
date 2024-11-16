{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  imports = [
    ../../shared/user/apps/firefox.nix
    ../../shared/user/apps/mpd.nix
    ../../shared/user/development/c.nix
    ../../shared/user/development/git.nix
    ../../shared/user/development/go.nix
    ../../shared/user/development/lazygit.nix
    ../../shared/user/development/nvim.nix
    ../../shared/user/development/ruby.nix
    ../../shared/user/shell/fish.nix
    ../../shared/user/services/picom.nix
    ../../shared/user/shell/starship.nix
    ../../shared/user/utilities/eza.nix
    ../../shared/user/utilities/yazi.nix
    ../../shared/user/utilities/kitty.nix
    ../../shared/user/desktop/i3wm.nix
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
      brightnessctl
      chromium
      discord
      gimp
      godot_4
      graphviz
      jq
      killall
      osu-lazer-bin
      postman
      spotify
      texliveFull
      unzip
    ];
  };
}
