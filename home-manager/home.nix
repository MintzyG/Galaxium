{ inputs, ... }:

{
  programs.home-manager.enable = true;

  home = { 
    stateVersion = "23.11";

    username = "sophia";
    homeDirectory = "/home/sophia/";
    
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "chromium";
      TERMINAL = "kitty";
    };
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
    };
  };

  catppuccin = {
    flavor = "macchiato";
    accent = "mauve";
  };

  imports = [ 
    ./apps.nix
    ./bat.nix
    ./dev.nix
    ./eza.nix
    ./fish.nix
    ./git.nix
    ./hyprland.nix
    ./kitty.nix 
    ./lazygit.nix
    ./otd.nix
    ./ranger.nix
    ./starship.nix
    ./swww.nix
    ./yazi.nix
    ./zsh.nix
  ];
}
