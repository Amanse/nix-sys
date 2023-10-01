{pkgs, ...}: {
  home.packages = with pkgs; [alacritty rofi-wayland wlsunset wayshot grim batsignal mako playerctl pamixer];

  imports = [./hyprpaper.nix];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
    settings = {exec-once = ["${pkgs.hyprpaper}/bin/hyprpaper"];};
    systemdIntegration = true;
  };
}
