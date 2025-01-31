{ pkgs, inputs, ... }:

{
  programs.home-manager.enable = true;

  imports = [
    ../../shared/user/apps/mpd.nix
    ../../shared/user/development/c.nix
    ../../shared/user/development/git.nix
    ../../shared/user/development/go.nix
    ../../shared/user/development/lazygit.nix
    ../../shared/user/development/nvim.nix
    ../../shared/user/shell/fish.nix
    ../../shared/user/services/ags.nix
    ../../shared/user/services/swww.nix
    ../../shared/user/shell/starship.nix
    ../../shared/user/utilities/btop.nix
    ../../shared/user/utilities/eza.nix
    ../../shared/user/utilities/hyfetch.nix
    ../../shared/user/utilities/yazi.nix
    ../../shared/user/utilities/kitty.nix
    ../../shared/user/desktop/hyprland.nix
    ../../shared/user/user/pfp.nix
  ];

  home = {
    stateVersion = "24.05";
    username = "sophia";
    homeDirectory = "/home/sophia/";
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "zen";
    };
    packages = with pkgs; [ 
      inputs.zen-browser.packages."x86_64-linux".twilight
      brightnessctl
      discord
      gimp
      godot_4
      jq
      killall
      osu-lazer-bin
      postman
      spotify
      unzip
    ];
  };
}
