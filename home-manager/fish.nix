_:

{
  programs.fish = {
    enable = true;
    loginShellInit = "source (/home/sophia/.nix-profile/bin/starship init fish --print-full-init | psub)";
  };
}
