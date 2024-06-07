{
  description = "The eye of the universe";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:MintzyG/Celestium";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { nixpkgs, home-manager, catppuccin, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    nixosConfigurations = {
      galaxium = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ 
          ./modules/nixos
          catppuccin.nixosModules.catppuccin
        ];
        specialArgs = { 
          inherit inputs; 
        };
      };
    };

    homeConfigurations = { 
      sophia = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./modules/home
          catppuccin.homeManagerModules.catppuccin
        ];
        extraSpecialArgs = { 
          inherit inputs; 
        };
      };
    };
  };
}
