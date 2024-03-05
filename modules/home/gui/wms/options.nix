{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption types mkOption;
in {
  options.myHome.gui.wms = {
    enable = mkEnableOption "Enable window manager helping programs like bar notification daemon";
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
    sway = {
      enable = mkEnableOption "Enable sway";
      package = mkOption {
        type = types.package;
        default = pkgs.sway;
      };
    };
  };
}
