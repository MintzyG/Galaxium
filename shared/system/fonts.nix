{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [ 
      (nerdfonts.override { fonts = [ "JetBrainsMono" "NerdFontsSymbolsOnly" ]; })
      noto-fonts-emoji
    ];

    fontconfig.defaultFonts = {
      serif = [ "JetBrains Mono" ];
      sansSerif = [ "JetBrains Mono" ];
      monospace = [ "JetBrains Mono" ];
    };
  };
}
