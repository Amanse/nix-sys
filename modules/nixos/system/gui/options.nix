{
  lib,
  config,
  ...
}:
with lib; {
  options.myModules.gui = {
    enable = mkEnableOption "Enable gui";
    desktops = mkOption {
      type = with types; listOf str;
      default = [];
    };
    loginManagers = mkOption {
      type = with types; listOf str;
      default = [];
    };
    defaultSession = mkOption {
      type = types.str;
      default = builtins.elemAt config.myModules.gui.desktops 0;
    };
  };

  config.services.xserver.displayManager.defaultSession = config.myModules.gui.defaultSession;
}
