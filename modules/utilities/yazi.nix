{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
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
      manager.append_keymap = [
        {
          on = ["<Right>"];
          run = ["open --state=none"];
          desc = "Open file";
        }
      ];
    };

  };
}
