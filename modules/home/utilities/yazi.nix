{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    catppuccin.enable = true;

    settings = {
      log = {
        enabled = false;
      };

      manager = {
        show_hidden = false;
        sort_dir_first = true;
      };
    };

    keymap = {
      manager = [
        { 
          on = [ "<C-s>" ]; 
          exec = "shell fish --block --confirm"; 
        }
      ];
    };
  };
}
