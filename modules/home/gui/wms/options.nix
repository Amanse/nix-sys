{lib, ...}: let
  inherit (lib) mkEnableOption types mkOption;
in {
  options.myHome.gui.wms = {
    wallpaper.hyprpaper = {
      enable = mkEnableOption "Enable hyprpaper for wallpaper";
      wallpaper = mkOption {
        type = types.path;
        default = "${./hypr/night.png}";
      };
    };
    hyprland = {
      enable = mkEnableOption "Enable Hyprland";
    };
    sway.enable = mkEnableOption "Enable sway";
  };
}
