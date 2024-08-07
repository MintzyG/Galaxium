{
  imports = [
    ./bluetooth.nix
    ./nvidia.nix
    ./sound.nix
  ];

  hardware.opentabletdriver.enable = true;
}
