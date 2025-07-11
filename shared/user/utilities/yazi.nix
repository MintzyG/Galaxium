{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      log = {
        enabled = false;
      };

      mgr = {
        show_hidden = false;
        sort_dir_first = true;
      };
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = ["<C-s>"];
          run = ''shell "$SHELL" --block --confirm'';
          desc = "Open shell here";
        }
      ];
    };
  };
}
