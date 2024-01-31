{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.myHome.gui.wms.wallpaper.hyprpaper;
in {
  xdg.configFile = mkIf cfg.enable {
    "hypr/hyprpaper.conf".text = ''
      preload = ${cfg.wallpaper}

      wallpaper = ,${cfg.wallpaper}

      ipc=false
      splash=true
    '';
  };
}
