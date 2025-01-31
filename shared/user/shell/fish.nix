{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      neofetch = "hyfetch";
      hy = "hyfetch";
      nf = "hyfetch";
      cfg = "yazi ~/.config/galaxium/";
      cfn = "yazi ~/.config/Celestium/";
      le = "eza --icons --color=always --git";
      gg = "lazygit";
      yy = "yazi";
    };
  };

  home.packages = with pkgs; [
    fd
    fzf
  ];
}
