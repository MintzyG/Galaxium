{
  imports = [
    ./nvidia.nix
    ./sound.nix
  ];

  virtualisation.docker.enable = true;
  hardware.opentabletdriver.enable = true;
}
