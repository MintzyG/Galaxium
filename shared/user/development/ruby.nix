{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ruby
    rubyPackages_3_4.rails
  ];
}

