{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) types mkOption;
in {
  options.myHome = {
    startupCmds = mkOption {
      type = types.listOf types.str;
      default = [config.myHome.notide];
    };

    runner = mkOption {
      type = types.str;
      default = "${pkgs.rofi-wayland}/bin/rofi -show drun";
    };

    terminal = mkOption {
      type = types.str;
      default = "${lib.getExe pkgs.alacritty}";
    };

    notide = mkOption {
      type = types.str;
      default = "${lib.getExe pkgs.swaynotificationcenter}";
    };

    browser = mkOption {
      type = types.str;
      default = "${lib.getExe pkgs.google-chrome}";
    };
  };
}
