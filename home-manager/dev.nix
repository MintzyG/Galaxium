{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # gnat
    # rustup
    ciao
    dotnet-sdk_8
    elixir
    freeglut
    gcc
    gdb
    geckodriver
    gh
    git
    go
    inputs.nixvim.packages."x86_64-linux".default
    jdk21
    python3
    python311Packages.pygments
    racket
    rars
    rustc
    scilab-bin
    swiProlog
    vscode
  ];
}
