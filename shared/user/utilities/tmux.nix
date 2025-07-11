{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    prefix = "C-Space";
    keyMode = "vi";
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-capture-pane-contents 'on'";
      }

      {
        plugin = continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
    ];
    extraConfig = ''
      unbind %
      bind h split-window -h

      unbind '"'
      bind v split-window -v

      bind -r i resize-pane -U 5
      bind -r j resize-pane -L 5
      bind -r k resize-pane -D 5
      bind -r l resize-pane -R 5

      bind -r m resize-pane -Z
    '';
  };
}
