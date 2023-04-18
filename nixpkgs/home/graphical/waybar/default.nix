{ lib
, pkgs
, hyprland
, ...
}:
{
  programs.waybar = {
    enable = true;
    package = hyprland.packages."x86_64-linux".waybar-hyprland;
    settings = [ (import ./waybar.nix { inherit lib pkgs; }) ];
    style = builtins.readFile ./waybar.css;
  };
}
