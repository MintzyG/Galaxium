{ inputs, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home = {
    stateVersion = "24.05";
    username = "nova";
    homeDirectory = "/home/nova/";

    packages = with pkgs; [
      inputs.nixvim.packages."x86_64-linux".default
      yazi
    ];

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      #TERMINAL = "kitty";

      FLAKE = "/home/sophia/.config/galaxium";
    };

  };

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
  };
}
