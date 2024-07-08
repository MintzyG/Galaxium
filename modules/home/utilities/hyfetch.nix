_:

{
  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "transfeminine";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.7;
      color_align = {
        mode = "horizontal";
        custom_colors = "[]";
      };
      backend = "neofetch";
    };
  };
}
