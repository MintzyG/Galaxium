{
  description = "System flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
	allowUnfree = true;
      };
    };

  in
  {
    nixosConfigurations = {
      galaxium = nixpkgs.lib.nixosSystem{
        specialArgs = { inherit system; };
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };
    homeConfigurations = {
      sophia = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home-manager/home.nix ];
      };
    };
  };
}
