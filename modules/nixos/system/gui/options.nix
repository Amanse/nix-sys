{lib, ...}:
with lib; {
  options.myModules.gui = {
    enable = mkEnableOption "Enable gui";
    desktops = mkOption {
      type = with types; listOf str;
      default = [];
    };
    loginManagers = {
      type = with types; listOf str;
      default = [];
    };
    defaultSession = mkOption {
      type = types.string;
      default = lists.take 1 desktops;
    };
  };
}
