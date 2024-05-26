{ ... }:

{
  imports = [ ./imports.nix ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [ "electron-25.9.0" ];
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command"  "flakes" ];
    };
  };
}
