{lib, ...}: let
  inherit (lib) mkOption types mkEnableOption;

  rcloneConfig = types.submodule {
    options = {
      mountDir = mkOption {type = types.str;};
      configName = mkOption {type = types.str;};
    };
  };
in {
  options.myHome.services.rclone = {
    enable = mkEnableOption "Enable Rclone services";
    configs = mkOption {
      type = with types; listOf rcloneConfig;
    };
  };
}
