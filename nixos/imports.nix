{ lib, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./environment.nix
    ./battery.nix
    ./system.nix
    ./nvidia.nix
    ./sound.nix
    ./video.nix
    ./games.nix
    ./user.nix
    ./apps.nix
  ];
}
