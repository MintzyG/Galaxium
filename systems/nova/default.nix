{ pkgs, ... }:

{
  imports = [
    ../../shared/system/docker.nix
    ../../shared/system/locale.nix
    ../../shared/system/nix.nix
    ../../shared/system/postgres.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "nova";

  programs.fish.enable = true;
  users.users.nova = {
    isNormalUser = true;
    description = "WSL system user";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
    shell = pkgs.fish;
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  system.stateVersion = "24.05";
}
