{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption mkOption types;

  cfg = config.myHome.runners.rofi;

  variants = [];

  catppuccin = pkgs.fetchFromGitHub {
    "owner" = "catppuccin";
    "repo" = "rofi";
    "rev" = "5350da41a11814f950c3354f090b90d4674a95ce";
    "hash" = "sha256-DNorfyl3C4RBclF2KDgwvQQwixpTwSRu7fIvihPN8JY=";
  };
in {
  options.myHome.runners.rofi = {
    enable = mkEnableOption "Enable rofi";
    theme = {
      catppuccin = {
        enable = mkEnableOption "Enable catppuccin theme";
        variant = mkOption {
          type = types.enum ["latte" "frappe" "macchiato" "mocha"];
          default = "mocha";
        };
      };
    };
  };

  config = mkIf cfg.theme.catppuccin.enable {
    xdg.configFile."rofi/config.rasi".source = catppuccin + "/basic/.config/rofi/config.rasi";
    xdg.configFile."rofi/catppuccin-${cfg.theme.catppuccin.variant}.rasi".source = catppuccin + "/basic/.local/share/rofi/themes/catppuccin-${cfg.theme.catppuccin.variant}.rasi";
  };
}
