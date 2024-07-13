{ pkgs, ... }:

{
  imports = [
    ./nvim.nix
  ];

  home.packages = with pkgs; [
    # gnat
    docker
    docker-compose
    dotnet-sdk_8
    freeglut
    gcc
    gdb
    glibc
    gnumake
    go
    jdk21
    pkg-config
    python3
    python311Packages.pygments
  ];
}
