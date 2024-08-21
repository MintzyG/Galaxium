_:

{
  programs.home-manager.enable = true;

  imports = [
    ../../shared/user/shell/fish.nix
    ../../shared/user/shell/starship.nix
    ../../shared/user/utilities/eza.nix
    ../../shared/user/utilities/yazi.nix
    ../../shared/user/development/nvim.nix
    ../../shared/user/development/git.nix
    ../../shared/user/development/lazygit.nix
  ];

  home = {
    stateVersion = "24.05";
    username = "nova";
    homeDirectory = "/home/nova/";
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
    };
  };
}
