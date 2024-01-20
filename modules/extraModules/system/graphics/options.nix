{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption;
in {
  options.myModules.graphics = {
    intel = {
      enable = mkEnableOption "Enable intel GPU stuff";
    };

    nvidia = {
      enable = mkEnableOption "Enable nvidia gpu stuff";
      package = mkOption {
        type = lib.types.package;
        default = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    };
  };
}
