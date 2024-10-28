{
  description = "The eye of the universe";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:MintzyG/Celestium";
    catppuccin.url = "github:catppuccin/nix";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs-stable, nixpkgs, home-manager, catppuccin, nixos-wsl, ... } @ inputs:
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
          ./systems/elysium
            catppuccin.nixosModules.catppuccin
        ];
        specialArgs = {
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
          inherit inputs;
        };
      };
      nova = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nixos-wsl.nixosModules.default
          {
            imports = [
              ./systems/nova
            ];
          }
        ];
      };
      heXen = nixpkgs.lib.nixosSystem {
        inherit system;
	modules = [
          ./systems/heXen
	  catppuccin.nixosModules.catppuccin
	];
	specialArgs = {
          pkgs-stable = import nixpkgs-stable {
            inherit system;
	    config.allowUnfree = true;
	  };
	  inherit inputs;
	};
      };
    };

    homeConfigurations = {
      sophia = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/sophia
          catppuccin.homeManagerModules.catppuccin
        ];
        extraSpecialArgs = {
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
          inherit inputs;
        };
      };
      nova = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/nova
          catppuccin.homeManagerModules.catppuccin
        ];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
      minimal = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/minimal
          catppuccin.homeManagerModules.catppuccin
        ];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
