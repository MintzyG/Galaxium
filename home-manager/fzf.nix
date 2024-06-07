{ pkgs, lib, ... }: 

let
  fd = lib.getExe pkgs.fd;
in 

{
  programs.fzf = rec {
    enable = true;
    enableZshIntegration = true;

    defaultOptions = [ "--height 50%" ];

    defaultCommand = "${fd} --hidden --strip-cwd-prefix --exclude .git";
    
    # Ctrl-T
    fileWidgetCommand = "${defaultCommand}";
    fileWidgetOptions = [ "--preview 'if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi'" ];

    # Ctrl-C
    changeDirWidgetCommand = "${fd} --type=d --hidden --strip-cwd-prefix --exclude .git";
    changeDirWidgetOptions = ["--preview 'eza --tree --color=always {} | head -200'"];
  };
}
