{
  programs.home-manager.enable = true;
  home.stateVersion = "23.11";

  imports = [ 
    ./apps
    ./desktop/hyprland
    ./development
    ./git
    ./services
    ./shell
    ./user
    ./utilities
  ];
}
