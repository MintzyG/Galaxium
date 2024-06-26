{ pkgs, ... }:

{
  imports = [
    ./nvim.nix
  ];
      

  home.packages = with pkgs; [
    # gnat
    # rustup
    dotnet-sdk_8
    elixir
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
    rars
    rustc
    vscode
  ];
}
