{ config, pkgs, ... }:

{
  imports = [
    ./entertainment
    ./hardware
    ./networking
    ./system
    ./user
  ];

  config.services.postgresql = {
    enable = true;
    ensureDatabases = [ "scti-db" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };
}
