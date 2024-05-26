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
  };
}
