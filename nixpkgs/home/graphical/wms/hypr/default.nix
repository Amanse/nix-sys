{hyprland, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland.packages."x86_64-linux".default;
    extraConfig = builtins.readFile ./hyprland.conf;
    systemdIntegration = true;
  };

  home.packages = [hyprland.packages.x86_64-linux.xdg-desktop-portal-hyprland];
}
