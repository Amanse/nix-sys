{pkgs, ...}: {
  imports = [./hyprpaper.nix];
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    recommendedEnvironment = true;
    extraConfig = builtins.readFile ./hyprland.conf;
    systemdIntegration = true;
  };
}
