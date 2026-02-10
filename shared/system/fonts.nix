{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      noto-fonts-color-emoji
    ];

    fontconfig.defaultFonts = {
      serif = [ "JetBrains Mono" ];
      sansSerif = [ "JetBrains Mono" ];
      monospace = [ "JetBrains Mono" ];
    };
  };
}
