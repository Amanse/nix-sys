{
  lib,
  pkgs,
  config,
  ...
}: {
  programs.waybar = {
    enable = true;
    # package = pkgs.waybar-hyprland;
    settings = [(import ./waybar.nix {inherit lib pkgs config;})];
    style = builtins.readFile ./waybar.css;
  };
}
