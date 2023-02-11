{
  inputs,
  self,
  ...
}: {
  imports = [
    ./hyprland
    ./rofi
#    ./office
    inputs.hyprland.homeManagerModules.default
  ];
}
