{ inputs, pkgs, ... }:
let
  everforest-light-soft = {
    scheme = "Everforest Light Soft";
    author = "sainnhe";
    base00 = "f3ead3";
    base01 = "eae4ca";
    base02 = "e5dfc5";
    base03 = "939f91";
    base04 = "829181";
    base05 = "5c6a72";
    base06 = "475258";
    base07 = "2e383c";
    base08 = "f85552";
    base09 = "f57d26";
    base0A = "dfa000";
    base0B = "8da101";
    base0C = "35a77c";
    base0D = "3a94c5";
    base0E = "df69ba";
    base0F = "e66868";
  };

  everforest-light-medium = {
    scheme = "Everforest Light Medium";
    author = "sainnhe";
    base00 = "fdf6e3";
    base01 = "f4efe0";
    base02 = "edeada";
    base03 = "939f91";
    base04 = "829181";
    base05 = "5c6a72";
    base06 = "475258";
    base07 = "2e383c";
    base08 = "f85552";
    base09 = "f57d26";
    base0A = "dfa000";
    base0B = "8da101";
    base0C = "35a77c";
    base0D = "3a94c5";
    base0E = "df69ba";
    base0F = "e66868";
  };

  everforest-light-hard = {
    scheme = "Everforest Light Hard";
    author = "sainnhe";
    base00 = "fffbef";
    base01 = "f8f0d8";
    base02 = "f2eacd";
    base03 = "939f91";
    base04 = "829181";
    base05 = "5c6a72";
    base06 = "475258";
    base07 = "2e383c";
    base08 = "f85552";
    base09 = "f57d26";
    base0A = "dfa000";
    base0B = "8da101";
    base0C = "35a77c";
    base0D = "3a94c5";
    base0E = "df69ba";
    base0F = "e66868";
  };
in
{
 imports = [ inputs.stylix.homeModules.stylix ];
  stylix = {
    enable = true;
    base16Scheme = everforest-light-hard;

    targets = {
      qt = {
        enable = true;
      };
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 30;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };
  };
}
