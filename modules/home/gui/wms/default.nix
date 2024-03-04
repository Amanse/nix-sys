{pkgs, ...}: {
  imports = [./hypr ./sway ./i3 ./options.nix ./paper/config.nix];

  home.packages = [pkgs.swaynotificationcenter];
}
