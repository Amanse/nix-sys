{pkgs, ...}: {
  home.packages = with pkgs; [alacritty bemenu wlsunset wayshot grim batsignal mako playerctl pamixer];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
    systemdIntegration = true;
  };
}
