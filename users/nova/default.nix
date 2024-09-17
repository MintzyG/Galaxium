{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  imports = [
    ../../shared/user/development/c.nix
    ../../shared/user/development/git.nix
    ../../shared/user/development/go.nix
    ../../shared/user/development/latex.nix
    ../../shared/user/development/lazygit.nix
    ../../shared/user/development/nvim.nix
    ../../shared/user/shell/fish.nix
    ../../shared/user/shell/starship.nix
    ../../shared/user/utilities/eza.nix
    ../../shared/user/utilities/yazi.nix
  ];

  home = {
    stateVersion = "24.05";
    username = "nova";
    homeDirectory = "/home/nova/";
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
    };
    packages = with pkgs; [
    # Criar .nix para zellij
      zellij
    ];
  };
}
