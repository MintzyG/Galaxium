{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # gnat
    # rustup
    ciao
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
