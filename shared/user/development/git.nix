{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.email = "ericbraga2000@gmail.com";
      user.name = "MintzyG";
      extraConfig = {
        github.user = "MintzyG";
        init.defaultBranch = "main";
      };
    };
    lfs.enable = true;
  };

  programs.difftastic = {
    enable = true;
    git.enable = true;
    options.display = "side-by-side-show-both";
  };

  home.packages = with pkgs; [
    gh
  ];
}
