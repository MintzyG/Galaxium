{ config, pkgs, ... }:

{
  imports = [ ./imports.nix ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ "electron-25.9.0" ];
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command"  "flakes" ];
      substituters = ["https://nix-gaming.cachix.org"];
      trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    };
  };
}
