{lib, ...}: let
  inherit (lib) mkEnableOption mkOption types;
in {
  options.myHome.services.onedrive = {
    enable = mkEnableOption "enable onedrive serivce";
    syncDirs = mkOption {
      type = with types; listOf str;
      default = [];
    };
  };
}
