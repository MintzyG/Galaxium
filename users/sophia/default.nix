{ pkgs, inputs, ... }:

{
  programs.home-manager.enable = true;

  imports = [
    ../../shared/user/apps/mpd.nix
    ../../shared/user/apps/obs.nix
    ../../shared/user/development/c.nix
    ../../shared/user/development/extra.nix
    ../../shared/user/development/git.nix
    ../../shared/user/development/go.nix
    ../../shared/user/development/lazygit.nix
    ../../shared/user/development/nvim.nix
    ../../shared/user/shell/fish.nix
    ../../shared/user/services/swww.nix
    ../../shared/user/shell/starship.nix
    ../../shared/user/utilities/btop.nix
    ../../shared/user/utilities/eza.nix
    ../../shared/user/utilities/hyfetch.nix
    ../../shared/user/utilities/yazi.nix
    ../../shared/user/utilities/kitty.nix
    ../../shared/user/utilities/ghostty.nix
    ../../shared/user/utilities/stylix.nix
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
      TERMINAL = "ghostty";
    };
    packages = with pkgs; [ 
      inputs.zen-browser.packages."x86_64-linux".default
      inputs.quickshell.packages."x86_64-linux".default
      brightnessctl
      chromium
      code-cursor
      discord
      docker-compose
      jdk23
      jq
      killall
      unzip
    ];
  };
}
