{ pkgs, ... }:

{
  fonts.packages = with pkgs; [ 
    jetbrains-mono
    noto-fonts-emoji
  ];
}
