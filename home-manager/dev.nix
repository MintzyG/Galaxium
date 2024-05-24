{ lib, config, pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # gnat
    # rustup
    ciao
    freeglut
    gcc
    gdb
    geckodriver
    gh
    git
    go
    jdk21
    # neovim
    inputs.nixvim.packages."x86_64-linux".default
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
