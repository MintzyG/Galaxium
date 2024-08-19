{ config, lib, pkgs, ... }:

{
  #imports = [
  #];

  wsl.enable = true;
  wsl.defaultUser = "nova";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];    

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    gh
    git
    home-manager
    nh
    nix-output-monitor
    nvd
    neovim
  ];

  system.stateVersion = "24.05"; # Did you read the comment?
}
