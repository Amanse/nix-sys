{
  config,
  lib,
  ...
}: let
  cfg = config.myModules.gaming.deckSwapVal;
in {
  options.myModules.gaming.deckSwapVal = lib.mkEnableOption "use the swappiness and map count from steam deck and fedora";

  config = lib.mkIf cfg {
    boot.kernel.sysctl = {
      "vm.swappiness" = 5;
      "vm.max_map_count" = 2147483642; # the value from steam deck and fedora
    };
  };
}
