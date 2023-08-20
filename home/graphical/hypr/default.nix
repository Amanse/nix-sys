{pkgs, ...}: {
  home.packages = with pkgs; [alacritty bemenu wlsunset wayshot grim batsignal mako playerctl];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    recommendedEnvironment = true;
    extraConfig = builtins.readFile ./hyprland.conf;
    systemdIntegration = true;
  };
}
