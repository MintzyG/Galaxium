{ config, pkgs, lib, ... }: 
{
  programs.git = {
    enable = true;

    userEmail = "ericbraga2000@gmail.com";
    userName = "MintzyG";
  };
}