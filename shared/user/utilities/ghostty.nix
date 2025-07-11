{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    settings = {
      background-opacity = 0.6;
      background-blur-radius = 10;
      scrollback-limit = 20000;
    };
  };
}
