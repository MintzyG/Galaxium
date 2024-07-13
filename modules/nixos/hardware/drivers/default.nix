{
  imports = [
    ./nvidia.nix
    ./sound.nix
  ];

  hardware.opentabletdriver.enable = true;
}
