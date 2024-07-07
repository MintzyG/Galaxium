{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAbbrs = { 
      cfg = "yazi ~/.config/galaxium/";
      cfn = "yazi ~/.config/Celestium/";
      le = "eza --icons --color=always --git";
      gg = "lazygit";
      e = "yazi";
    };
  };

  home.packages = with pkgs; [
    fd
    fzf
  ];
}
