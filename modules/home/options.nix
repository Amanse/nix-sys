{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types mkOption;
in {
  options.myHome = {
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
