{pkgs, ...}: {
  imports = [./hyprpaper.nix ./config.nix];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
  };
}
