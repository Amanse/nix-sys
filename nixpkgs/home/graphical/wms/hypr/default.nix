{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    extraConfig = builtins.readFile ./hyprland.conf;
    systemdIntegration = true;
  };

  #  home.packages = [hyprland.packages.x86_64-linux.xdg-desktop-portal-hyprland];
}
