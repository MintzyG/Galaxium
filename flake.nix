{
  description = "The eye of the universe";

  outputs = { nixpkgs-stable, nixpkgs, home-manager, catppuccin, nixos-wsl, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      # Create a base system configuration function
      mkSystem = extraModules: specialArgs: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          catppuccin.nixosModules.catppuccin
        ] ++ extraModules;
        specialArgs = {
          inherit inputs pkgs-stable;
        } // specialArgs;
      };
      # Create a base home-manager configuration function
      mkHome = modules: extraSpecialArgs: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          catppuccin.homeModules.catppuccin
        ] ++ modules;
        extraSpecialArgs = {
          inherit inputs pkgs-stable;
        } // extraSpecialArgs;
      };
    in
      {
      nixosConfigurations = {
        galaxium = mkSystem [ ./systems/elysium ] {};
        heXen = mkSystem [ ./systems/heXen ] {};
        nova = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            nixos-wsl.nixosModules.default
            ./systems/nova
          ];
        };
      };

      homeConfigurations = {
        sophia = mkHome [ ./users/sophia ] {};
        nova = mkHome [ ./users/nova ] {};
        minimal = mkHome [ ./users/minimal ] {};
      };
    };

  inputs = {
    # Core
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = { 
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System Specific
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Ricing
    catppuccin.url = "github:catppuccin/nix";
    ags.url = "github:aylur/ags";

    # Applications
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixvim.url = "github:MintzyG/Celestium";
  };
}
