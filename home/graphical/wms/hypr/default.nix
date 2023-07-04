{pkgs, ...}: {
  imports = [./hyprpaper.nix];

  home.packages = [pkgs.hyprpaper];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    recommendedEnvironment = true;
    extraConfig = builtins.readFile ./hyprland.conf;
    systemdIntegration = true;
  };
}
