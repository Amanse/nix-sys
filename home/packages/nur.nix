{lib, pkgs,...}:
let
  nur-no-pkgs = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {};
in
{
  imports = lib.attrValues nur-no-pkgs.repos.iagocq.ultimmc; 

  home.packages = [nur-no-pkgs.repos.iagocq.ultimmc];

}
