{
  pkgs,
  inputs,
  ...
}: {
  imports = [./hyprpaper.nix ./config.nix];

  home.packages = [pkgs.grim pkgs.slurp];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    systemd = {
      enable = true;
      # variables = ["--all"];
    };
  };
}
