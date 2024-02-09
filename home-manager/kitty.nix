{ lib, config, packages, ... }:
{
  programs.kitty = {
    enable = true;
    
    settings = {
      disable_ligatures = "never";
      background_opacity = "0.6";

      # Font
      font_family = "JetBrains Mono";
      
      # Font Variations
      bold_font = "JetBrains Mono Bold";
      italic_font = "JetBrains Mono Italic";
      bold_italic_font = "JetBrains Mono Bold Italic";
    };

    theme = "Catppuccin-Macchiato";
  };
}
