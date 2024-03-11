{ lib, config, pkgs, ... }:

{
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    xwaylandvideobridge
    discord-canary
    prismlauncher
    wl-clipboard
    home-manager
    pavucontrol
    protontricks
	texliveMedium
    noisetorch
    chromium
    winetricks
    glxinfo
    spotify
    obsidian
	zathura
    heroic
    vscode
    neovim
    rustup
    rustc
    slurp
    ngrok
    wofi
    swww
    wine
    wget
    grim
    gnat
    gcc
    git
    go
    gh
  ];
}
