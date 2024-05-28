_: 

{
  programs.git = {
    enable = true;

    userEmail = "ericbraga2000@gmail.com";
    userName = "MintzyG";

    extraConfig = {
      github.user = "MintzyG";
      init.defaultBranch = "main";
    };
  };
}
