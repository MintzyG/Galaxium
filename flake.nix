{
  description = "System flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixvim.url = "github:MintzyG/Celestium";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  {
    nixosConfigurations.galaxium = nixpkgs.lib.nixosSystem{
      specialArgs = { inherit inputs; };
      modules = [
        ./nixos/configuration.nix
      ]; 
    };

    homeConfigurations.sophia = home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = { inherit inputs; };
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      modules = [ ./home-manager/home.nix ];
    };
  };
}
