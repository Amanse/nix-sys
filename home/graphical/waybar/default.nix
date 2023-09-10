{
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    # package = pkgs.waybar-hyprland;
    settings = [(import ./waybar.nix {inherit lib pkgs;})];
    style = builtins.readFile ./waybar.css;
  };
}
