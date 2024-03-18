{ lib, config, pkgs, ... }:

{
  environment.sessionVariables = {
    EDITOR = "nvim";
  };
}
