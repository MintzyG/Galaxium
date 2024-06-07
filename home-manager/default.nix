{
  programs.home-manager.enable = true;

  home = { 
    stateVersion = "23.11";

    username = "sophia";
    homeDirectory = "/home/sophia/";
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  catppuccin = {
    flavor = "macchiato";
    accent = "mauve";
  };

  imports = [ 
    ../modules/desktop/hyprland
    ../modules/git
    ../modules/kitty.nix 
    ../modules/services
    ../modules/shell
    ../modules/utilities
    ./apps.nix
    ./dev.nix
    ./home_variables.nix
  ];
}
