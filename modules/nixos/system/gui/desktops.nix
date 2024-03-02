{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  dsk = config.myModules.gui.desktops;
  solved = {
    "gnome" = {
      services.xserver.desktopManager.gnome.enable = true;
      environment.gnome.excludePackages = with pkgs.gnome; [
        gnome-software
        geary
        totem
        gnome-music
        epiphany
      ];
    };
    "hyprland" = {
      services.dbus.packages = with pkgs; [hyprland];

      services.xserver.displayManager.sessionPackages = [pkgs.hyprland];

      xdg.portal = {
        enable = true;
        config = {
          common = {
            "org.freedesktop.impl.portal.Secret" = [
              "gnome-keyring"
            ];
          };
        };
        extraPortals = [
          pkgs.xdg-desktop-portal-hyprland
        ];
      };
    };
    "plasma" = {
      services.xserver.desktopManager.plasma6.enable = true;
    };
  };
in {
  disabledModules = ["programs/hyprland.nix"];

  config = mkMerge [
    (mkIf (builtins.elem "hyprland" dsk) solved.hyprland)
    (mkIf (builtins.elem "gnome" dsk) solved.gnome)
    (mkIf (builtins.elem "plasma" dsk) solved.plasma)
  ];
}
