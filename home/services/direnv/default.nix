{
  config,
  lib,
  pkgs,
  self,
  ...
}:
{
  programs.direnv = {
    enable=true;
    nix-direnv.enable=true;
  };
}
