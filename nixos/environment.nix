{ pkgs, ... }:

{
  fonts.packages = with pkgs; [ 
    jetbrains-mono
    noto-fonts-emoji
    nerdfonts
  ];

  environment.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "chromium";
    TERMINAL = "kitty";
    FLAKE = "/home/sophia/galaxium";
  };



  environment.systemPackages = with pkgs; [
    nh
    nix-output-monitor
    nvd
  ];
}
