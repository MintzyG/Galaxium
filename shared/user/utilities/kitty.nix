{
  programs.kitty = {
    enable = true;

    settings = {
      disable_ligatures = "never";
      background_opacity = "0.6";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      open_url_with = "firefox";

      font_family = "JetBrains Mono";
      bold_font = "JetBrains Mono Bold";
      italic_font = "JetBrains Mono Italic";
      bold_italic_font = "JetBrains Mono Bold Italic";
    };

    themeFile = "Catppuccin-Macchiato";
  };
}
