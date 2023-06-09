{pkgs, ...}: {
  imports = [./hyprpaper.nix];
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    extraConfig = builtins.readFile ./hyprland.conf;
    systemdIntegration = true;
  };
}
