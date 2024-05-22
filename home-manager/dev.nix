{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    racket
    rars
    scilab-bin
    python3
    python311Packages.pygments
    neovim
    geckodriver
    ciao
    freeglut
    gcc
    gdb
    gh
    git
    go
    jdk21
    swiProlog
    vscode
    rustc
    # gnat
    # rustup
  ];
}
