{ ... }:

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

  imports = [ 
    ./apps.nix
    ./dev.nix
    ./eza.nix
    ./fish.nix
    ./git.nix
    ./hyprland.nix
    ./kitty.nix 
    ./otd.nix
    ./ranger.nix
    ./starship.nix
    ./zsh.nix
  ];
}
