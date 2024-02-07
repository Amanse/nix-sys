{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [./config.nix];

  home.packages = [pkgs.grim pkgs.slurp];

  wayland.windowManager.hyprland = {
    enable = config.myHome.gui.wms.hyprland.enable;
    # package = inputs.hyprland.packages.${pkgs.system}.default;
    systemd = {
      enable = true;
      # variables = ["--all"];
    };
  };
}
