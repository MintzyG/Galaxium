{
  imports = [
    ./styling.nix
    ./user.nix
    ./pfp.nix
  ];

  # nix = {
  #   settings = {
  #     experimental-features = [ "nix-command"  "flakes" ];
  #     substituters = ["https://hyprland.cachix.org"];
  #     trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  #   };
  # };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
