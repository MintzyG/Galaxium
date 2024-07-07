{ pkgs, ... }:

{
  imports = [
    ./nvim.nix
  ];
      

  home.packages = with pkgs; [
    # gnat
    rustup
    # cargo
    dotnet-sdk_8
    freeglut
    gcc
    gccMultiStdenv
    gdb
    geckodriver
    glibc
    gnumake
    go
    jdk21
    python3
    python311Packages.pygments
    # rustc
  ];
}
