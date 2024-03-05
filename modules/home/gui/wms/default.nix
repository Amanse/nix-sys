{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [./hypr ./sway ./i3 ./options.nix ./paper/config.nix];

  home.packages = lib.optionals config.myHome.gui.wms.enable [pkgs.swaynotificationcenter];
}
