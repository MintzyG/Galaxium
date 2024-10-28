{ pkgs, ... }:

{
  fonts.packages = with pkgs; [ 
    nerdfonts
    jetbrains-mono
    noto-fonts-emoji
  ];
}
