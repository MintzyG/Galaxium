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
      manager.prepend_keymap = [
        {
          on = ["<C-s>"];
          run = ''shell "$SHELL" --block --confirm'';
          desc = "Open shell here";
        }
      ];
    };
  };
}
