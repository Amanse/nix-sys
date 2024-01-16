{inputs, ...}: let
  system = "x86_64-linux";
in {
  imports = [./hyprpaper.nix ./config.nix];

  wayland.windowManager.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${system}.default;
    # plugins = [
    #   inputs.hyprland-plugins.packages.${system}.hyprbars
    # ];
    systemd.enable = true;
  };
}
