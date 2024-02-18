{
  config,
  lib,
  ...
}: let
  inherit (lib) mkMerge mkIf;
  cfg = config.myModules.gui.loginManagers;
in {
  config.services.xserver.displayManager = mkMerge [
    (mkIf (builtins.elem "sddm" cfg) {
      sddm.enable = true;
      sddm.wayland.enable = true;
      sddm.theme = "sddm-catppuccin-corners";
    })
    (mkIf (builtins.elem "gdm" cfg) {
      gdm.enable = true;
      gdm.wayland.enable = true;
    })
  ];
}
