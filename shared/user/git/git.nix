{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    userEmail = "ericbraga2000@gmail.com";
    userName = "MintzyG";

    extraConfig = {
      github.user = "MintzyG";
      init.defaultBranch = "main";
    };

    lfs.enable = true;

    difftastic = {
      enable = true;
      display = "side-by-side-show-both";
    };
  };

  home.packages = with pkgs; [
    gh
  ];
}
